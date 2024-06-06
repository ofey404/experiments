import time
from prometheus_client import start_http_server, Gauge

STATIC = Gauge(
    "static",
    "This metric creates as soon as the script runs",
    labelnames=("my_label_key",),
)

if __name__ == "__main__":
    start_http_server(8000)
    STATIC.labels("my_label_value").set(0.1)  # set label value here
    time.sleep(999)
