package main

import (
	"fmt"
	"net/http"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
	counter = prometheus.NewCounter(
		prometheus.CounterOpts{
			Name: "requests_total",
			Help: "Total number of requests.",
		},
	)
	gauge = prometheus.NewGauge(
		prometheus.GaugeOpts{})
)

func init() {
	prometheus.MustRegister(counter)
}

func handler(w http.ResponseWriter, r *http.Request) {
	counter.Inc()
	w.Write([]byte("Hello, world!"))
	fmt.Printf("Request received, %s\n", r.RequestURI)
}

func main() {
	http.HandleFunc("/", handler)
	http.Handle("/metrics", promhttp.Handler())
	fmt.Printf("Starting server at :8080\n")
	http.ListenAndServe(":8080", nil)
}
