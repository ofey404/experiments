package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"time"

	"github.com/zeromicro/go-zero/core/logx"
)

const localJupyterURL = "http://localhost:8888"

// KernelStatus is from kubeflow notebook controller
type KernelStatus struct {
	ID             string `json:"id"`
	Name           string `json:"name"`
	LastActivity   string `json:"last_activity"`
	ExecutionState string `json:"execution_state"`
	Connections    int    `json:"connections"`
}

func (s *KernelStatus) MustParseLastActivity() time.Time {
	recentTime, err := time.Parse(time.RFC3339, s.LastActivity)
	logx.Must(err)
	return recentTime
}

func main() {
	kernels := getKernels()

	kernelsJson, err := json.MarshalIndent(kernels, "", "  ")
	logx.Must(err)
	fmt.Printf("kernels: %s\n", kernelsJson)

	for _, k := range kernels {
		fmt.Printf("k.MustParseLastActivity() = %s\n", k.MustParseLastActivity().Format(time.RFC3339))
	}
}

func getKernels() []KernelStatus {
	client := &http.Client{
		Timeout: time.Second * 10,
	}

	url, err := url.Parse(localJupyterURL)
	logx.Must(err)

	url.Path = "/api/kernels"

	resp, err := client.Get(url.String())
	logx.Must(err)
	defer resp.Body.Close()

	fmt.Printf("resp.StatusCode: %+v\n", resp.StatusCode)

	var kernels []KernelStatus
	err = json.NewDecoder(resp.Body).Decode(&kernels)
	logx.Must(err)

	return kernels
}
