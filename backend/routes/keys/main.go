package keys

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/phantomknight287/flyssh/backend/db"
	"github.com/phantomknight287/flyssh/backend/models"
	auth_utils "github.com/phantomknight287/flyssh/backend/utils/auth"
	"github.com/phantomknight287/flyssh/backend/utils/validation"
)

func RegisterRoutes(router *gin.Engine) {
	group := router.Group("/keys", auth_utils.AuthMiddleware())
	group.POST("", CreateKey)
	group.GET("", ListKeys)
	group.GET("/:id", GetKey)
	group.PUT("/:id", UpdateKey)
	group.DELETE("/:id", DeleteKey)
}

func keyToResponse(key db.Key) KeyResponse {
	return KeyResponse{
		ID:         key.ID,
		Label:      key.Label,
		Value:      key.Value,
		Passphrase: key.Passphrase,
		IV:         key.IV,
		CreatedAt:  key.CreatedAt,
		UpdatedAt:  key.UpdatedAt,
	}
}

// @Summary Create a new SSH key
// @Description Store a client-encrypted SSH key. The value and optional passphrase are opaque encrypted blobs.
// @Tags keys
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer token"
// @Param request body CreateKeyRequest true "Key details"
// @Success 201 {object} KeyResponse
// @Failure 400 {object} models.Error
// @Failure 401 {object} models.Error
// @Failure 500 {object} models.Error
// @Router /keys [post]
func CreateKey(c *gin.Context) {
	user := c.MustGet("user").(db.User)

	var request CreateKeyRequest
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, models.Error{
			Message:    "Validation failed",
			StatusCode: http.StatusBadRequest,
			Errors:     validation.FormatValidationErrors(err),
		})
		return
	}

	key := db.Key{
		Label:      request.Label,
		Value:      request.Value,
		Passphrase: request.Passphrase,
		IV:         request.IV,
		OwnerID:    user.ID,
	}

	if err := db.DB.Create(&key).Error; err != nil {
		c.JSON(http.StatusInternalServerError, models.Error{
			Message:    "Failed to create key",
			StatusCode: http.StatusInternalServerError,
		})
		return
	}

	c.JSON(http.StatusCreated, keyToResponse(key))
}

// @Summary List all SSH keys
// @Description Return all SSH keys belonging to the authenticated user.
// @Tags keys
// @Produce json
// @Param Authorization header string true "Bearer token"
// @Success 200 {array} KeyResponse
// @Failure 401 {object} models.Error
// @Router /keys [get]
func ListKeys(c *gin.Context) {
	user := c.MustGet("user").(db.User)

	var keys []db.Key
	db.DB.Where("owner_id = ?", user.ID).Order("created_at desc").Find(&keys)

	response := make([]KeyResponse, len(keys))
	for i, key := range keys {
		response[i] = keyToResponse(key)
	}

	c.JSON(http.StatusOK, response)
}

// @Summary Get a single SSH key
// @Description Return an SSH key by ID. Must belong to the authenticated user.
// @Tags keys
// @Produce json
// @Param Authorization header string true "Bearer token"
// @Param id path int true "Key ID"
// @Success 200 {object} KeyResponse
// @Failure 401 {object} models.Error
// @Failure 404 {object} models.Error
// @Router /keys/{id} [get]
func GetKey(c *gin.Context) {
	user := c.MustGet("user").(db.User)

	var key db.Key
	db.DB.First(&key, c.Param("id"))

	if key.ID == 0 {
		c.JSON(http.StatusNotFound, models.Error{
			Message:    "Key not found",
			StatusCode: http.StatusNotFound,
		})
		return
	}

	if key.OwnerID != user.ID {
		c.JSON(http.StatusNotFound, models.Error{
			Message:    "Key not found",
			StatusCode: http.StatusNotFound,
		})
		return
	}

	c.JSON(http.StatusOK, keyToResponse(key))
}

// @Summary Update an SSH key
// @Description Update fields of an existing SSH key. All fields are optional.
// @Tags keys
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer token"
// @Param id path int true "Key ID"
// @Param request body UpdateKeyRequest true "Fields to update"
// @Success 200 {object} KeyResponse
// @Failure 400 {object} models.Error
// @Failure 401 {object} models.Error
// @Failure 404 {object} models.Error
// @Router /keys/{id} [put]
func UpdateKey(c *gin.Context) {
	user := c.MustGet("user").(db.User)

	var key db.Key
	db.DB.First(&key, c.Param("id"))

	if key.ID == 0 || key.OwnerID != user.ID {
		c.JSON(http.StatusNotFound, models.Error{
			Message:    "Key not found",
			StatusCode: http.StatusNotFound,
		})
		return
	}

	var request UpdateKeyRequest
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, models.Error{
			Message:    "Validation failed",
			StatusCode: http.StatusBadRequest,
			Errors:     validation.FormatValidationErrors(err),
		})
		return
	}

	if request.Label != nil {
		key.Label = *request.Label
	}
	if request.Value != nil {
		key.Value = *request.Value
	}
	if request.Passphrase != nil {
		key.Passphrase = request.Passphrase
	}
	if request.IV != nil {
		key.IV = *request.IV
	}

	if err := db.DB.Save(&key).Error; err != nil {
		c.JSON(http.StatusInternalServerError, models.Error{
			Message:    "Failed to update key",
			StatusCode: http.StatusInternalServerError,
		})
		return
	}

	c.JSON(http.StatusOK, keyToResponse(key))
}

// @Summary Delete an SSH key
// @Description Delete an SSH key by ID. Associated hosts will have their keyId set to null.
// @Tags keys
// @Produce json
// @Param Authorization header string true "Bearer token"
// @Param id path int true "Key ID"
// @Success 200 {object} map[string]string
// @Failure 401 {object} models.Error
// @Failure 404 {object} models.Error
// @Router /keys/{id} [delete]
func DeleteKey(c *gin.Context) {
	user := c.MustGet("user").(db.User)

	var key db.Key
	db.DB.First(&key, c.Param("id"))

	if key.ID == 0 || key.OwnerID != user.ID {
		c.JSON(http.StatusNotFound, models.Error{
			Message:    "Key not found",
			StatusCode: http.StatusNotFound,
		})
		return
	}

	// Nullify KeyID on associated hosts
	db.DB.Model(&db.Host{}).Where("key_id = ?", key.ID).Update("key_id", nil)

	if err := db.DB.Delete(&key).Error; err != nil {
		c.JSON(http.StatusInternalServerError, models.Error{
			Message:    "Failed to delete key",
			StatusCode: http.StatusInternalServerError,
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Key deleted"})
}
