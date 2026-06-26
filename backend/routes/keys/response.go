package keys

import "time"

type KeyResponse struct {
	ID         uint      `json:"id"`
	Label      string    `json:"label"`
	Value      string    `json:"value"`
	Passphrase *string   `json:"passphrase"`
	IV         string    `json:"iv"`
	CreatedAt  time.Time `json:"createdAt"`
	UpdatedAt  time.Time `json:"updatedAt"`
}
