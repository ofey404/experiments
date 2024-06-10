package main

import (
	"os"
	"text/template"
)

type ScriptVars struct {
	Username string
	IsAdmin  bool
}

func mustParseFile() *template.Template {
	// Parse the template file
	tmpl, err := template.ParseFiles("script-template.sh.tmpl")
	if err != nil {
		panic(err)
	}
	return tmpl
}

func mustParseString() *template.Template {
	// Define your template directly as a string
	const tmplString = `
#!/bin/bash
echo "Parse from string"
echo "Welcome, {{.Username}}!"
{{ if .IsAdmin }}
echo "You have administrative privileges."
{{ else }}
echo "You are a standard user."
{{ end }}
`

	// Create a new template and parse the string
	tmpl, err := template.New("script").Parse(tmplString)
	if err != nil {
		panic(err)
	}
	return tmpl
}

func main() {
	// Define the variables to substitute in the template
	vars := ScriptVars{
		Username: "JohnDoe",
		IsAdmin:  true,
	}

	tmpl := mustParseFile()
	// tmpl := mustParseString()

	// Create the output file
	outFile, err := os.Create("generated-script.sh")
	if err != nil {
		panic(err)
	}
	defer outFile.Close()

	// Execute the template and write to the output file
	if err := tmpl.Execute(outFile, vars); err != nil {
		panic(err)
	}

	// Make the script executable
	os.Chmod("generated-script.sh", 0755)
}
