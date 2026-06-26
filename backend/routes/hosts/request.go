package hosts

type CreateHostRequest struct {
	Label    string  `json:"label" binding:"required"`
	Hostname string  `json:"hostname" binding:"required"`
	Username string  `json:"username" binding:"required"`
	Port     *int    `json:"port"`
	Password *string `json:"password"`
	KeyID    *uint   `json:"keyId"`
	IV       string  `json:"iv" binding:"required"`
}

type UpdateHostRequest struct {
	Label    *string `json:"label"`
	Hostname *string `json:"hostname"`
	Username *string `json:"username"`
	Port     *int    `json:"port"`
	Password *string `json:"password"`
	KeyID    *uint   `json:"keyId"`
	IV       *string `json:"iv"`
}

type UpdateHostOsRequest struct {
	OsId      *string `json:"osId"`
	OsName    *string `json:"osName"`
	OsVersion *string `json:"osVersion"`
}
