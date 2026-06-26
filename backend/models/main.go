package models

import "github.com/golang-jwt/jwt/v5"

type Error struct {
	Message    string            `json:"message"`
	StatusCode int               `json:"statusCode"`
	Errors     map[string]string `json:"errors,omitempty"`
}

type Claims struct {
	Id string `json:"id"`
	jwt.RegisteredClaims
}

type GenericResponse struct {
	Message string `json:"message"`
}
