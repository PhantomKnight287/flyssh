package auth

import (
	"crypto/rand"
	"encoding/base64"
	"fmt"
	"log"
	"net/http"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
	"github.com/phantomknight287/flyssh/backend/constants"
	"github.com/phantomknight287/flyssh/backend/db"
	"github.com/phantomknight287/flyssh/backend/models"
	auth_utils "github.com/phantomknight287/flyssh/backend/utils/auth"
	"github.com/phantomknight287/flyssh/backend/utils/validation"
)

func RegisterRoutes(router *gin.Engine) {
	router.POST("/auth/register", RegisterUser)
	router.POST("/auth/login", LoginUser)
	router.POST("/auth/recovery/setup", auth_utils.AuthMiddleware(), SetupRecovery)
	router.POST("/auth/recover", Recover)
}

// @Summary Register a new user
// @Description Create a new user account. The client must generate a master key locally, derive an authKey via PBKDF2(masterKey, email), and send the authKey as masterKeyHash. The server never sees the raw master key.
// @Tags auth
// @Accept json
// @Produce json
// @Param request body RegisterUserRequest true "Registration details"
// @Success 201 {object} RegisterUserResponse
// @Failure 400 {object} models.Error
// @Failure 409 {object} models.Error
// @Failure 500 {object} models.Error
// @Router /auth/register [post]
func RegisterUser(c *gin.Context) {
	var request RegisterUserRequest

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, models.Error{
			Message:    "Validation failed",
			StatusCode: http.StatusBadRequest,
			Errors:     validation.FormatValidationErrors(err),
		})
		return
	}

	var existingUser db.User

	db.DB.Where("lower(username) = ?", strings.ToLower(request.Username)).First(&existingUser)

	if existingUser.ID != 0 {
		c.JSON(http.StatusConflict, models.Error{
			Message: "Username already taken", StatusCode: http.StatusConflict,
		})
		return
	}

	var err error

	request.Password, err = auth_utils.GeneratedHashPassword(request.Password)

	if err != nil {
		log.Println("Error hashing password:", err)
		c.JSON(http.StatusInternalServerError, models.Error{Message: "Internal server error", StatusCode: http.StatusInternalServerError})
		return
	}

	masterKeyHash, err := auth_utils.GeneratedHashPassword(request.MasterKeyHash)
	if err != nil {
		log.Println("Error hashing master key:", err)
		c.JSON(http.StatusInternalServerError, models.Error{Message: "Internal server error", StatusCode: http.StatusInternalServerError})
		return
	}

	recoveryKeyBytes := make([]byte, 32)
	if _, err = rand.Read(recoveryKeyBytes); err != nil {
		log.Println("Error generating recovery key:", err)
		c.JSON(http.StatusInternalServerError, models.Error{Message: "Internal server error", StatusCode: http.StatusInternalServerError})
		return
	}
	recoveryKey := base64.URLEncoding.EncodeToString(recoveryKeyBytes)

	recoveryKeyHash, err := auth_utils.GeneratedHashPassword(recoveryKey)
	if err != nil {
		log.Println("Error hashing recovery key:", err)
		c.JSON(http.StatusInternalServerError, models.Error{Message: "Internal server error", StatusCode: http.StatusInternalServerError})
		return
	}

	user := db.User{
		Name:            request.Name,
		Password:        request.Password,
		Username:        request.Username,
		MasterKeyHash:   masterKeyHash,
		RecoveryKeyHash: recoveryKeyHash,
	}

	if err := db.DB.Create(&user).Error; err != nil {
		log.Println("Error creating user:", err)
		c.JSON(http.StatusInternalServerError, models.Error{Message: "Failed to create user", StatusCode: http.StatusInternalServerError})
		return
	}

	expiresAt := time.Now().Add(30 * 24 * time.Hour)

	claims := models.Claims{
		Id: fmt.Sprintf("%d", user.ID),
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(expiresAt),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString(constants.JWT_SECRET)
	if err != nil {
		log.Println("Error generating token:", err)
		c.JSON(http.StatusInternalServerError, models.Error{Message: "Internal server error", StatusCode: http.StatusInternalServerError})
		return
	}

	c.JSON(http.StatusCreated, RegisterUserResponse{
		Name:        user.Name,
		Username:    user.Username,
		Token:       tokenString,
		ExpiresAt:   expiresAt.Unix(),
		RecoveryKey: recoveryKey,
	})
}

// @Summary Login a user
// @Description Authenticate a user with username, password and masterKeyHash. The client derives authKey = PBKDF2(masterKey, email) and sends it as masterKeyHash. The server verifies it against the stored bcrypt hash.
// @Tags auth
// @Accept json
// @Produce json
// @Param request body LoginUserRequest true "Login details"
// @Success 200 {object} LoginUserResponse
// @Failure 400 {object} models.Error
// @Failure 401 {object} models.Error
// @Failure 500 {object} models.Error
// @Router /auth/login [post]
func LoginUser(c *gin.Context) {
	var request LoginUserRequest

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, models.Error{
			Message:    "Validation failed",
			StatusCode: http.StatusBadRequest,
			Errors:     validation.FormatValidationErrors(err),
		})
		return
	}

	var user db.User
	db.DB.Where("lower(username) = ?", strings.ToLower(request.Username)).First(&user)

	if user.ID == 0 {
		c.JSON(http.StatusUnauthorized, models.Error{
			Message:    "Invalid credentials",
			StatusCode: http.StatusUnauthorized,
		})
		return
	}

	if !auth_utils.VerifyPassword(request.Password, user.Password) {
		c.JSON(http.StatusUnauthorized, models.Error{
			Message:    "Invalid credentials",
			StatusCode: http.StatusUnauthorized,
		})
		return
	}

	if !auth_utils.VerifyPassword(request.MasterKeyHash, user.MasterKeyHash) {
		c.JSON(http.StatusUnauthorized, models.Error{
			Message:    "Invalid master key",
			StatusCode: http.StatusUnauthorized,
		})
		return
	}

	expiresAt := time.Now().Add(30 * 24 * time.Hour)

	claims := models.Claims{
		Id: fmt.Sprintf("%d", user.ID),
		RegisteredClaims: jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(expiresAt),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString(constants.JWT_SECRET)
	if err != nil {
		log.Println("Error generating token:", err)
		c.JSON(http.StatusInternalServerError, models.Error{Message: "Internal server error", StatusCode: http.StatusInternalServerError})
		return
	}

	c.JSON(http.StatusOK, LoginUserResponse{
		Name:      user.Name,
		Username:  user.Username,
		Token:     tokenString,
		ExpiresAt: expiresAt.Unix(),
	})
}

// @Summary Store encrypted master key for recovery
// @Description After registration, the client encrypts the raw master key using the recovery key (AES-GCM, client-side) and sends the encrypted blob to the server for storage.
// @Tags auth
// @Accept json
// @Produce json
// @Param request body SetupRecoveryRequest true "Encrypted master key blob"
// @Security BearerAuth
// @Success 200 {object} models.GenericResponse
// @Failure 400 {object} models.Error
// @Failure 401 {object} models.Error
// @Failure 500 {object} models.Error
// @Router /auth/recovery/setup [post]
func SetupRecovery(c *gin.Context) {
	var request SetupRecoveryRequest

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, models.Error{
			Message:    "Validation failed",
			StatusCode: http.StatusBadRequest,
			Errors:     validation.FormatValidationErrors(err),
		})
		return
	}

	user := c.MustGet("user").(db.User)

	user.EncryptedMasterKey = &request.EncryptedMasterKey
	if err := db.DB.Save(&user).Error; err != nil {
		log.Println("Error saving recovery setup:", err)
		c.JSON(http.StatusInternalServerError, models.Error{Message: "Failed to save recovery data", StatusCode: http.StatusInternalServerError})
		return
	}

	c.JSON(http.StatusOK, models.GenericResponse{
		Message: "Recovery setup complete",
	})
}

// @Summary Recover encrypted master key
// @Description Verify username, password, and recovery key, then return the encrypted master key blob. The client decrypts it locally. No JWT is issued — call /auth/login afterward.
// @Tags auth
// @Accept json
// @Produce json
// @Param request body RecoverRequest true "Recovery credentials"
// @Success 200 {object} RecoverResponse
// @Failure 400 {object} models.Error
// @Failure 401 {object} models.Error
// @Router /auth/recover [post]
func Recover(c *gin.Context) {
	var request RecoverRequest

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, models.Error{
			Message:    "Validation failed",
			StatusCode: http.StatusBadRequest,
			Errors:     validation.FormatValidationErrors(err),
		})
		return
	}

	var user db.User
	db.DB.Where("lower(username) = ?", strings.ToLower(request.Username)).First(&user)

	if user.ID == 0 {
		c.JSON(http.StatusUnauthorized, models.Error{
			Message:    "Invalid credentials",
			StatusCode: http.StatusUnauthorized,
		})
		return
	}

	if !auth_utils.VerifyPassword(request.Password, user.Password) {
		c.JSON(http.StatusUnauthorized, models.Error{
			Message:    "Invalid credentials",
			StatusCode: http.StatusUnauthorized,
		})
		return
	}

	if !auth_utils.VerifyPassword(request.RecoveryKey, user.RecoveryKeyHash) {
		c.JSON(http.StatusUnauthorized, models.Error{
			Message:    "Invalid recovery key",
			StatusCode: http.StatusUnauthorized,
		})
		return
	}

	if user.EncryptedMasterKey == nil {
		c.JSON(http.StatusBadRequest, models.Error{
			Message:    "Recovery not set up. Please call /auth/recovery/setup first.",
			StatusCode: http.StatusBadRequest,
		})
		return
	}

	c.JSON(http.StatusOK, RecoverResponse{
		EncryptedMasterKey: *user.EncryptedMasterKey,
	})
}
