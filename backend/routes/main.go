package routes

import (
	"github.com/gin-gonic/gin"
	"github.com/phantomknight287/flyssh/backend/routes/auth"
	"github.com/phantomknight287/flyssh/backend/routes/hosts"
	"github.com/phantomknight287/flyssh/backend/routes/keys"
)

func RegisterRoutes(c *gin.Engine) {
	auth.RegisterRoutes(c)
	keys.RegisterRoutes(c)
	hosts.RegisterRoutes(c)
}
