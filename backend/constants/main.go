package constants

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

var JWT_SECRET []byte

func init() {
	_ = godotenv.Load() // .env is optional (e.g. in containers)
	jwtSecret := []byte(os.Getenv("JWT_SECRET"))
	if len(jwtSecret) == 0 {
		log.Fatal("JWT_SECRET is not set in the environment variables")
	}
	JWT_SECRET = jwtSecret
}
