package main

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var (
	verbose bool
	count   int
	name    string
)

var rootCmd = &cobra.Command{
	Use:   "myapp",
	Short: "A brief description of your application",
	Long: `A longer description that spans multiple lines and likely contains
examples and usage of using your application.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Hello from myapp!")
		if verbose {
			fmt.Println("Verbose mode is on")
		}
		fmt.Printf("Count: %d\n", count)
		fmt.Printf("Name: %s\n", name)
	},
}

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Print the version number of myapp",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("myapp v1.0")
	},
}

var echoCmd = &cobra.Command{
	Use:   "echo [string to echo]",
	Short: "Echo anything to the screen",
	Args:  cobra.MinimumNArgs(1),
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Echo: " + args[0])
	},
}

func init() {
	rootCmd.AddCommand(versionCmd)
	rootCmd.AddCommand(echoCmd)

	rootCmd.Flags().BoolVarP(&verbose, "verbose", "v", false, "Enable verbose output")
	rootCmd.Flags().IntVarP(&count, "count", "c", 1, "Number of times to repeat")
	rootCmd.Flags().StringVarP(&name, "name", "n", "World", "Name to greet")
}

func main() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
