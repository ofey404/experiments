import io
import time

# This script is executed in a pod.
# runs/ is mounted as a CFS host directory
filename = "runs/test.log"

with io.open(filename, "w") as f:
    f.write(f"log at time {time.time()}")

with io.open(filename, "a") as f:
    f.write(f"log at time {time.time()}")

# root@cfs-append-experiment-writer-spinner:~# python reproduce-append-error.py
# Traceback (most recent call last):
#   File "/root/reproduce-append-error.py", line 9, in <module>
#     with io.open(filename, "a") as f:
# OSError: [Errno 95] Operation not supported: 'runs/test.log'
