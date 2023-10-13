import ray
import asyncio
import time


@ray.remote
def time_consuming_task_ray():
    time.sleep(10)
    print("time_consuming_task completed")
    return 1


async def time_consuming_task(callback):
    await asyncio.wait([time_consuming_task_ray.remote()])
    callback()


async def forever_sleeper():
    count = 0
    while True:
        print("forever_sleeper sleep {} seconds".format(count))
        await asyncio.sleep(1)
        count += 1


async def main():
    callback = lambda: print("callback executed")
    await asyncio.gather(
        time_consuming_task(callback),
        forever_sleeper(),
    )


asyncio.run(main())

# Output:
#
# python callback.py
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
