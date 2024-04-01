class MyClass:
    async def method(self, id) -> "MyClass":
        print(f'method {id} called')
        return self

        
        
c = MyClass()


async def main():
    await (
        await (
            await c.method(1)
        ).method(2)
    ).method(3)


if __name__ == "__main__":
    import asyncio
    asyncio.run(main())
