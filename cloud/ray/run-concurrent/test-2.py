import ray
import asyncio


async def async_generator():
    for i in range(3):
        yield i


async def fun_1():
    async for request_output in async_generator():
        print("request_output: ", request_output)


asyncio.run(fun_1())


@ray.remote
class AsyncActor:
    # multiple invocation of this method can be running in
    # the event loop at the same time
    async def run_concurrent(self):
        print("started")
        await asyncio.sleep(2)  # concurrent workload here
        print("finished")
        async for request_output in async_generator():
            print("request_output: ", request_output)
            yield request_output


actor = AsyncActor.remote()


# async ray.get
async def async_get():
    # TypeError: 'async_generator' object is not iterable 
    r = actor.run_concurrent.remote()
    await r


# 模拟四个ray worker
asyncio.run(async_get())
