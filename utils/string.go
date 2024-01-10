package utils

import (
	"encoding/json"
	"github.com/zeromicro/go-zero/core/logx"
	"math/rand"
	"time"
)

func RandomString(length int) string {
	const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	random := rand.New(rand.NewSource(time.Now().UnixNano()))
	result := make([]byte, length)
	for i := 0; i < length; i++ {
		result[i] = charset[random.Intn(len(charset))]
	}
	return string(result)
}

func SprintAsJson(obj any) string {
	json, err := json.MarshalIndent(obj, "", "    ")
	logx.Must(err)

	return string(json)
}
