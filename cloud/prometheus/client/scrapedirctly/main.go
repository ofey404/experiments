package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/prometheus/common/expfmt"
)

func main() {
	resp, err := http.Get("http://localhost:8000")
	if err != nil {
		fmt.Printf("Error making request: %v\n", err)
		return
	}
	defer resp.Body.Close()

	var parser expfmt.TextParser
	metrics, err := parser.TextToMetricFamilies(resp.Body)
	if err != nil {
		fmt.Printf("Error parsing metrics: %v\n", err)
		return
	}

	for name, mf := range metrics {
		fmt.Printf("Metric: %s\n", name)
		for _, m := range mf.GetMetric() {
			jsonValue, err := json.Marshal(m)
			if err != nil {
				fmt.Printf("Error serializing value to JSON: %v\n", err)
				continue
			}
			fmt.Printf("  Value: %s\n", jsonValue)
		}
	}
}
