package encryption

import (
	"crypto/pbkdf2"
	"crypto/rand"
	"crypto/sha256"
	"encoding/base64"
	"fmt"
)

const KEY_LENGTH int = 16
const SALT_LENGTH int = 16
const PBKDF2_ITERATIONS int = 600000
const PBKDF2_KEY_LENGTH = 32

func GenerateMasterKey() (string, error) {
	key := make([]byte, KEY_LENGTH)
	if _, err := rand.Read(key); err != nil {
		return "", fmt.Errorf("failed to generate master key: %w", err)
	}
	return base64.URLEncoding.EncodeToString(key), nil
}

func DeriveKey(key string, salt []byte) []byte {
	newKey, err := pbkdf2.Key(sha256.New, key, salt, PBKDF2_ITERATIONS, PBKDF2_KEY_LENGTH)
	if err != nil {
		panic(err)
	}
	return newKey
}
