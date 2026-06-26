package auth

type RegisterUserResponse struct {
	Name        string `json:"name"`
	Username    string `json:"username"`
	Token       string `json:"token"`
	ExpiresAt   int64  `json:"expiresAt"`
	RecoveryKey string `json:"recoveryKey"`
}

type LoginUserResponse struct {
	Name      string `json:"name"`
	Username  string `json:"username"`
	Token     string `json:"token"`
	ExpiresAt int64  `json:"expiresAt"`
}

type RecoverResponse struct {
	EncryptedMasterKey string `json:"encryptedMasterKey"`
}
