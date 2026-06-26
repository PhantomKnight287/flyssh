package db

import "gorm.io/gorm"

type User struct {
	gorm.Model

	Name               string
	Username           string `gorm:"unique"`
	Password           string
	MasterKeyHash      string
	RecoveryKeyHash    string
	EncryptedMasterKey *string

	Hosts []Host `gorm:"foreignKey:OwnerID;constraint:OnDelete:CASCADE"`
	Keys  []Key  `gorm:"foreignKey:OwnerID;constraint:OnDelete:CASCADE"`
}

type Host struct {
	gorm.Model
	Label    string
	Hostname string
	Username string
	Port     int `gorm:"default:22"`
	Password *string
	KeyID    *uint
	Key      *Key `gorm:"foreignKey:KeyID"`
	OwnerID  uint
	Owner    User `gorm:"foreignKey:OwnerID"`
	IV       string
	// OS detection info (client-detected, stored for display)
	OsId      *string
	OsName    *string
	OsVersion *string
}

type Key struct {
	gorm.Model
	Label      string
	Value      string
	Passphrase *string
	Hosts      []Host `gorm:"foreignKey:KeyID"`
	OwnerID    uint
	Owner      User `gorm:"foreignKey:OwnerID"`
	IV         string
}
