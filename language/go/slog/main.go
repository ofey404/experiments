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
//
// {"time":"2024-01-30T18:08:02.471728227+08:00","level":"DEBUG","msg":"Debug message","key":"value"}
// {"time":"2024-01-30T18:08:02.471729814+08:00","level":"INFO","msg":"Info message","key":"value"}
// {"time":"2024-01-30T18:08:02.471731284+08:00","level":"WARN","msg":"Warning message","key":"value"}
// {"time":"2024-01-30T18:08:02.471732865+08:00","level":"ERROR","msg":"Error message","key":"value"}

func main() {
	logger := slog.New(slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{
		Level: slog.LevelDebug,
	}))

	logger.Debug("Debug message")
	logger.Info("Info message")
	logger.Warn("Warning message")
	logger.Error("Error message")

	// With some extra key-value pairs:
	logger2 := logger.With("key", "value")
	logger2.Debug("Debug message")
	logger2.Info("Info message")
	logger2.Warn("Warning message")
	logger2.Error("Error message")
}

// Another good resource:
//
// https://learninggolang.com/
// Learn Go by building a REST API and a Command Line Interface (CLI)
