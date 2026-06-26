package keys

type CreateKeyRequest struct {
	Label      string  `json:"label" binding:"required"`
	Value      string  `json:"value" binding:"required"`
	Passphrase *string `json:"passphrase"`
	IV         string  `json:"iv" binding:"required"`
}

type UpdateKeyRequest struct {
	Label      *string `json:"label"`
	Value      *string `json:"value"`
	Passphrase *string `json:"passphrase"`
	IV         *string `json:"iv"`
}
