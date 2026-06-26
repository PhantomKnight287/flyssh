package main

import (
	"fmt"
	"net/http"
	"os"
	"time"

	scalargo "github.com/bdpiprava/scalar-go"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/phantomknight287/flyssh/backend/db"
	"github.com/phantomknight287/flyssh/backend/routes"
)

// @title FlySsh API
// @version 1.0
// @description API server for FlySsh
func main() {
	r := gin.Default()
	db.Init()
	r.Use(
		cors.New(cors.Config{
			AllowOrigins:    []string{"*"},
			AllowMethods:    []string{"GET", "POST", "OPTIONS", "PATCH", "DELETE", "HEAD", "PUT"},
			AllowHeaders:    []string{"Origin", "Content-Type", "Authorization", "Accept"},
			MaxAge:          12 * time.Hour,
			AllowWebSockets: true,
		}))

	r.GET("/", func(ctx *gin.Context) {
		ctx.JSON(http.StatusAccepted, gin.H{
			"message": "Hello World",
		})
	})

	routes.RegisterRoutes(r)

	r.GET("/docs/openapi.json", func(ctx *gin.Context) {
		spec, err := os.ReadFile("swagger.json")
		if err != nil {
			ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		ctx.Data(http.StatusOK, "application/json", spec)
	})
	r.GET("/docs", func(ctx *gin.Context) {
		scheme := "http"
		if ctx.Request.TLS != nil {
			scheme = "https"
		}
		specURL := fmt.Sprintf("%s://%s/docs/openapi.json", scheme, ctx.Request.Host)
		html, err := scalargo.NewV2(
			scalargo.WithSpecURL(specURL),
		)
		if err != nil {
			ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		ctx.Data(http.StatusOK, "text/html; charset=utf-8", []byte(html))
	})

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	r.Run(":" + port)
}
