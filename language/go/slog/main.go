package main

import (
	"log/slog"
	"os"
)

// https://go.dev/blog/slog

// go run .
// {"time":"2024-01-30T17:44:00.83971413+08:00","level":"DEBUG","msg":"Debug message"}
// {"time":"2024-01-30T17:44:00.839779555+08:00","level":"INFO","msg":"Info message"}
// {"time":"2024-01-30T17:44:00.839781549+08:00","level":"WARN","msg":"Warning message"}
// {"time":"2024-01-30T17:44:00.839783097+08:00","level":"ERROR","msg":"Error message"}

func main() {
	logger := slog.New(slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
		Level: slog.LevelDebug,
	}))

	logger.Debug("Debug message")
	logger.Info("Info message")
	logger.Warn("Warning message")
	logger.Error("Error message")
}
