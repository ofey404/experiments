import ray
import asyncio

async def async_generator():
    for i in range(3):
        yield i
        await asyncio.sleep(1)

@ray.remote
class AsyncActor:
    # multiple invocation of this method can be running in
    # the event loop at the same time
    async def run_concurrent(self):
        print("started")
        await asyncio.sleep(2) # concurrent workload here
        print("finished")
        async for request_output in async_generator:
            yield request_output

actor = AsyncActor.remote()

# async ray.get
async def async_get():
    out = await actor.run_concurrent.remote()
    print("async_get out: ", out)
    return out

#模拟四个ray worker
results = [async_get() for _ in range(4)]

print("results: ", results)

async def main(results):
    out = await asyncio.gather(*results)
    print("main out: ", out)
    return out

output = asyncio.run(main(results))
print(output)
