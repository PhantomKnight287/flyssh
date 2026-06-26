package hosts

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/phantomknight287/flyssh/backend/db"
	"github.com/phantomknight287/flyssh/backend/models"
	"github.com/phantomknight287/flyssh/backend/routes/keys"
	auth_utils "github.com/phantomknight287/flyssh/backend/utils/auth"
	"github.com/phantomknight287/flyssh/backend/utils/validation"
)

func RegisterRoutes(router *gin.Engine) {
	group := router.Group("/hosts", auth_utils.AuthMiddleware())
	group.POST("", CreateHost)
	group.GET("", ListHosts)
	group.GET("/:id", GetHost)
	group.PUT("/:id", UpdateHost)
	group.DELETE("/:id", DeleteHost)
	group.PATCH("/:id/os", UpdateHostOs)
}

func keyToResponse(key *db.Key) *keys.KeyResponse {
	if key == nil {
		return nil
	}
	return &keys.KeyResponse{
		ID:         key.ID,
		Label:      key.Label,
		Value:      key.Value,
		Passphrase: key.Passphrase,
		IV:         key.IV,
		CreatedAt:  key.CreatedAt,
		UpdatedAt:  key.UpdatedAt,
	}
}

func hostToResponse(host db.Host) HostResponse {
	return HostResponse{
		ID:        host.ID,
		Label:     host.Label,
		Hostname:  host.Hostname,
		Username:  host.Username,
		Port:      host.Port,
		Password:  host.Password,
		KeyID:     host.KeyID,
		Key:       keyToResponse(host.Key),
		IV:        host.IV,
		OsId:      host.OsId,
		OsName:    host.OsName,
		OsVersion: host.OsVersion,
		CreatedAt: host.CreatedAt,
		UpdatedAt: host.UpdatedAt,
	}
}

// @Summary Create a new host
// @Description Store an SSH host configuration. Password is a client-encrypted blob. A key can optionally be attached.
// @Tags hosts
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer token"
// @Param request body CreateHostRequest true "Host details"
// @Success 201 {object} HostResponse
// @Failure 400 {object} models.Error
// @Failure 401 {object} models.Error
// @Failure 500 {object} models.Error
// @Router /hosts [post]
func CreateHost(c *gin.Context) {
	user := c.MustGet("user").(db.User)

	var request CreateHostRequest
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, models.Error{
			Message:    "Validation failed",
			StatusCode: http.StatusBadRequest,
			Errors:     validation.FormatValidationErrors(err),
		})
		return
	}

	if request.KeyID != nil {
		var key db.Key
		db.DB.First(&key, *request.KeyID)
		if key.ID == 0 || key.OwnerID != user.ID {
			c.JSON(http.StatusBadRequest, models.Error{
				Message:    "Key not found or does not belong to you",
				StatusCode: http.StatusBadRequest,
			})
			return
		}
	}

	host := db.Host{
		Label:    request.Label,
		Hostname: request.Hostname,
		Username: request.Username,
		Password: request.Password,
		KeyID:    request.KeyID,
		IV:       request.IV,
		OwnerID:  user.ID,
	}

	if request.Port != nil {
		host.Port = *request.Port
	}

	if err := db.DB.Create(&host).Error; err != nil {
		c.JSON(http.StatusInternalServerError, models.Error{
			Message:    "Failed to create host",
			StatusCode: http.StatusInternalServerError,
		})
		return
	}

	// Reload with key preloaded
	db.DB.Preload("Key").First(&host, host.ID)

	c.JSON(http.StatusCreated, hostToResponse(host))
}

// @Summary List all hosts
// @Description Return all SSH hosts belonging to the authenticated user, with keys preloaded.
// @Tags hosts
// @Produce json
// @Param Authorization header string true "Bearer token"
// @Success 200 {array} HostResponse
// @Failure 401 {object} models.Error
// @Router /hosts [get]
func ListHosts(c *gin.Context) {
	user := c.MustGet("user").(db.User)

	var hosts []db.Host
	db.DB.Where("owner_id = ?", user.ID).Preload("Key").Order("created_at desc").Find(&hosts)

	response := make([]HostResponse, len(hosts))
	for i, host := range hosts {
		response[i] = hostToResponse(host)
	}

	c.JSON(http.StatusOK, response)
}

// @Summary Get a single host
// @Description Return an SSH host by ID with its key preloaded. Must belong to the authenticated user.
// @Tags hosts
// @Produce json
// @Param Authorization header string true "Bearer token"
// @Param id path int true "Host ID"
// @Success 200 {object} HostResponse
// @Failure 401 {object} models.Error
// @Failure 404 {object} models.Error
// @Router /hosts/{id} [get]
func GetHost(c *gin.Context) {
	user := c.MustGet("user").(db.User)

	var host db.Host
	db.DB.Preload("Key").First(&host, c.Param("id"))

	if host.ID == 0 || host.OwnerID != user.ID {
		c.JSON(http.StatusNotFound, models.Error{
			Message:    "Host not found",
			StatusCode: http.StatusNotFound,
		})
		return
	}

	c.JSON(http.StatusOK, hostToResponse(host))
}

// @Summary Update a host
// @Description Update fields of an existing SSH host. All fields are optional. If keyId is provided, the key must belong to the same user.
// @Tags hosts
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer token"
// @Param id path int true "Host ID"
// @Param request body UpdateHostRequest true "Fields to update"
// @Success 200 {object} HostResponse
// @Failure 400 {object} models.Error
// @Failure 401 {object} models.Error
// @Failure 404 {object} models.Error
// @Router /hosts/{id} [put]
func UpdateHost(c *gin.Context) {
	user := c.MustGet("user").(db.User)

	var host db.Host
	db.DB.First(&host, c.Param("id"))

	if host.ID == 0 || host.OwnerID != user.ID {
		c.JSON(http.StatusNotFound, models.Error{
			Message:    "Host not found",
			StatusCode: http.StatusNotFound,
		})
		return
	}

	var request UpdateHostRequest
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, models.Error{
			Message:    "Validation failed",
			StatusCode: http.StatusBadRequest,
			Errors:     validation.FormatValidationErrors(err),
		})
		return
	}

	if request.KeyID != nil {
		var key db.Key
		db.DB.First(&key, *request.KeyID)
		if key.ID == 0 || key.OwnerID != user.ID {
			c.JSON(http.StatusBadRequest, models.Error{
				Message:    "Key not found or does not belong to you",
				StatusCode: http.StatusBadRequest,
			})
			return
		}
	}

	if request.Label != nil {
		host.Label = *request.Label
	}
	if request.Hostname != nil {
		host.Hostname = *request.Hostname
	}
	if request.Username != nil {
		host.Username = *request.Username
	}
	if request.Port != nil {
		host.Port = *request.Port
	}
	if request.Password != nil {
		host.Password = request.Password
	}
	if request.KeyID != nil {
		host.KeyID = request.KeyID
	}
	if request.IV != nil {
		host.IV = *request.IV
	}

	if err := db.DB.Save(&host).Error; err != nil {
		c.JSON(http.StatusInternalServerError, models.Error{
			Message:    "Failed to update host",
			StatusCode: http.StatusInternalServerError,
		})
		return
	}

	// Reload with key preloaded
	db.DB.Preload("Key").First(&host, host.ID)

	c.JSON(http.StatusOK, hostToResponse(host))
}

// @Summary Delete a host
// @Description Delete an SSH host by ID. Must belong to the authenticated user.
// @Tags hosts
// @Produce json
// @Param Authorization header string true "Bearer token"
// @Param id path int true "Host ID"
// @Success 200 {object} map[string]string
// @Failure 401 {object} models.Error
// @Failure 404 {object} models.Error
// @Router /hosts/{id} [delete]
func DeleteHost(c *gin.Context) {
	user := c.MustGet("user").(db.User)

	var host db.Host
	db.DB.First(&host, c.Param("id"))

	if host.ID == 0 || host.OwnerID != user.ID {
		c.JSON(http.StatusNotFound, models.Error{
			Message:    "Host not found",
			StatusCode: http.StatusNotFound,
		})
		return
	}

	if err := db.DB.Delete(&host).Error; err != nil {
		c.JSON(http.StatusInternalServerError, models.Error{
			Message:    "Failed to delete host",
			StatusCode: http.StatusInternalServerError,
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Host deleted"})
}

// @Summary Update host OS info
// @Description Update the detected OS information for a host
// @Tags hosts
// @Accept json
// @Produce json
// @Param Authorization header string true "Bearer token"
// @Param id path int true "Host ID"
// @Param request body UpdateHostOsRequest true "OS info"
// @Success 200 {object} HostResponse
// @Failure 401 {object} models.Error
// @Failure 404 {object} models.Error
// @Router /hosts/{id}/os [patch]
func UpdateHostOs(c *gin.Context) {
	user := c.MustGet("user").(db.User)

	var host db.Host
	db.DB.First(&host, c.Param("id"))

	if host.ID == 0 || host.OwnerID != user.ID {
		c.JSON(http.StatusNotFound, models.Error{
			Message:    "Host not found",
			StatusCode: http.StatusNotFound,
		})
		return
	}

	var request UpdateHostOsRequest
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, models.Error{
			Message:    "Validation failed",
			StatusCode: http.StatusBadRequest,
			Errors:     validation.FormatValidationErrors(err),
		})
		return
	}

	host.OsId = request.OsId
	host.OsName = request.OsName
	host.OsVersion = request.OsVersion

	if err := db.DB.Save(&host).Error; err != nil {
		c.JSON(http.StatusInternalServerError, models.Error{
			Message:    "Failed to update host OS info",
			StatusCode: http.StatusInternalServerError,
		})
		return
	}

	db.DB.Preload("Key").First(&host, host.ID)
	c.JSON(http.StatusOK, hostToResponse(host))
}
