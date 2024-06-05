import time
from prometheus_client import start_http_server, Gauge
import signal

STATIC = Gauge("static", "This metric creates as soon as the script runs")
DYNAMIC = None


def add_metrics_on_the_fly(signum, frame):
    print("add metrics on the fly")
    DYNAMIC = Gauge("dynamic", "This metric creates when the function runs")
    DYNAMIC.set(1)
    STATIC.set(1)


# Hook the SIGUSR1 signal to the add_metrics_on_the_fly function
signal.signal(signal.SIGUSR1, add_metrics_on_the_fly)

if __name__ == "__main__":

    # Start up the server to expose the metrics.

    start_http_server(8000)

    # Generate some requests.

    STATIC.set(0.1)
    time.sleep(999)
