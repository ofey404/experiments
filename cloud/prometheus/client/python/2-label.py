from prometheus_client import start_http_server, Summary

import random

import time


# Create a metric to track time spent and requests made.

REQUEST_TIME = Summary(
    "request_processing_seconds",
    "Time spent processing request",
    labelnames=("my_label_key",),
)


# Decorate function with metric.


TIMER = REQUEST_TIME.time()
TIMER.labels("my_label_value")


@TIMER
def process_request(t):
    """A dummy function that takes some time."""

    time.sleep(t)


if __name__ == "__main__":

    # Start up the server to expose the metrics.

    start_http_server(8000)

    # Generate some requests.

    while True:

        process_request(random.random())
