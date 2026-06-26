package hosts

import (
	"time"

	"github.com/phantomknight287/flyssh/backend/routes/keys"
)

type HostResponse struct {
	ID        uint              `json:"id"`
	Label     string            `json:"label"`
	Hostname  string            `json:"hostname"`
	Username  string            `json:"username"`
	Port      int               `json:"port"`
	Password  *string           `json:"password"`
	KeyID     *uint             `json:"keyId"`
	Key       *keys.KeyResponse `json:"key"`
	IV        string            `json:"iv"`
	OsId      *string           `json:"osId,omitempty"`
	OsName    *string           `json:"osName,omitempty"`
	OsVersion *string           `json:"osVersion,omitempty"`
	CreatedAt time.Time         `json:"createdAt"`
	UpdatedAt time.Time         `json:"updatedAt"`
}
