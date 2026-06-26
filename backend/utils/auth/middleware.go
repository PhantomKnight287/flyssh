package auth_utils

import (
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/phantomknight287/flyssh/backend/db"
	"github.com/phantomknight287/flyssh/backend/models"
)

func AuthMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		header := c.GetHeader("Authorization")
		if header == "" || !strings.HasPrefix(header, "Bearer ") {
			c.AbortWithStatusJSON(http.StatusUnauthorized, models.Error{
				Message:    "Missing or invalid authorization header",
				StatusCode: http.StatusUnauthorized,
			})
			return
		}

		tokenString := strings.TrimPrefix(header, "Bearer ")

		claims, err := ParseToken(tokenString)
		if err != nil {
			c.AbortWithStatusJSON(http.StatusUnauthorized, models.Error{
				Message:    "Invalid or expired token",
				StatusCode: http.StatusUnauthorized,
			})
			return
		}

		var user db.User
		db.DB.First(&user, claims.Id)

		if user.ID == 0 {
			c.AbortWithStatusJSON(http.StatusUnauthorized, models.Error{
				Message:    "User not found",
				StatusCode: http.StatusUnauthorized,
			})
			return
		}

		c.Set("user", user)
		c.Next()
	}
}
