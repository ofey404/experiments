package main_test

import (
	"regexp"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestMain(t *testing.T) {
	// you cannot directly include a backtick inside a raw string literal.
	var specialCharacterPattern = regexp.MustCompile(`[!"#$%&'()*+,\-./:;<=>?@\[\\\]^_{|}~` + "`" + `]`)
	tests := []struct {
		name        string
		input       string
		matchString bool
	}{
		{
			name:        "space",
			input:       "",
			matchString: false,
		},
		{
			name:        "special character",
			input:       "!",
			matchString: true,
		},
		{
			name:        "special character",
			input:       "@",
			matchString: true,
		},
		{
			name:        "escaped",
			input:       "-",
			matchString: true,
		},
		{
			name:        "escaped",
			input:       "[",
			matchString: true,
		},
		{
			name:        "escaped",
			input:       "\\",
			matchString: true,
		},
		{
			name:        "backtick",
			input:       "`",
			matchString: true,
		},
		{
			name:        "plain",
			input:       "abcd",
			matchString: false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			assert.Equal(t, tt.matchString, specialCharacterPattern.MatchString(tt.input))
		})
	}

}
