package main

import (
	"time"

	"github.com/google/uuid"
	"github.com/zeromicro/go-zero/core/logx"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

type Product struct {
	ID        uuid.UUID `gorm:"type:uuid;primary_key;"`
	CreatedAt time.Time
	UpdatedAt time.Time
	DeletedAt gorm.DeletedAt `gorm:"index"`
	Code      string
	Price     uint
}

// BeforeCreate will set a UUID rather than numeric ID.
func (product *Product) BeforeCreate(tx *gorm.DB) (err error) {
	product.ID = uuid.New()
	return
}

func main() {
	db, err := gorm.Open(sqlite.Open("test.sqlite"), &gorm.Config{})
	if err != nil {
		panic("failed to connect database")
	}

	// Migrate the schema
	err = db.AutoMigrate(&Product{})
	logx.Must(err)

	// Create
	tx := db.Create(&Product{Code: "D42", Price: 100})
	logx.Must(tx.Error)

	// Read
	var product Product
	tx = db.First(&product, "code = ?", "D42") // find product with code D42
	logx.Must(tx.Error)

	// Update - update product's price to 200
	tx = db.Model(&product).Update("Price", 200)
	logx.Must(tx.Error)

	// Update - update multiple fields
	tx = db.Model(&product).Updates(Product{Price: 200, Code: "F42"}) // non-zero fields
	logx.Must(tx.Error)

	tx = db.Model(&product).Updates(map[string]interface{}{"Price": 200, "Code": "F42"})
	logx.Must(tx.Error)

	// Delete - delete product
	tx = db.Delete(&product)
	logx.Must(tx.Error)
}
