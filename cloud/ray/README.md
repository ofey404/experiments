# ray

This directory explores some features of [ray-project/ray](https://github.com/ray-project/ray)
as a tryout.

## Installation

```bash
pip install ray
```

## [./actor_concurrent_call.py](./actor_concurrent_call.py):

This script verifies: multiple calls to the same actor would be queued,
rather than running concurrently.

## [./callback.py](./callback.py)

This script builds a callback feature based on asyncio and `ray.remote()`.

```bash
python callback.py 
# 2023-02-22 18:55:26,656 INFO worker.py:1538 -- Started a local Ray instance.
# forever_sleeper sleep 0 seconds
# forever_sleeper sleep 1 seconds
# forever_sleeper sleep 2 seconds
# forever_sleeper sleep 3 seconds
# forever_sleeper sleep 4 seconds
# forever_sleeper sleep 5 seconds
# forever_sleeper sleep 6 seconds
# forever_sleeper sleep 7 seconds
# forever_sleeper sleep 8 seconds
# forever_sleeper sleep 9 seconds
# forever_sleeper sleep 10 seconds
# callback executed
# (time_consuming_task_ray pid=1741) time_consuming_task completed
# forever_sleeper sleep 11 seconds
# forever_sleeper sleep 12 seconds
```