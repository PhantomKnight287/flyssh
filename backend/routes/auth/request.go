package auth

type RegisterUserRequest struct {
	Name          string `json:"name" binding:"required"`
	Username      string `json:"username" binding:"required"`
	Password      string `json:"password" binding:"required"`
	MasterKeyHash string `json:"masterKeyHash" binding:"required"`
}

type LoginUserRequest struct {
	Username      string `json:"username" binding:"required"`
	Password      string `json:"password" binding:"required"`
	MasterKeyHash string `json:"masterKeyHash" binding:"required"`
}

type SetupRecoveryRequest struct {
	EncryptedMasterKey string `json:"encryptedMasterKey" binding:"required"`
}

type RecoverRequest struct {
	Username    string `json:"username" binding:"required"`
	Password    string `json:"password" binding:"required"`
	RecoveryKey string `json:"recoveryKey" binding:"required"`
}
