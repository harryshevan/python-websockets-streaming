import asyncio
from websockets.server import serve


async def echo(websocket, path):
    async for message in websocket:
        await websocket.send("Server response: " + message)


async def main():
    async with serve(echo, "0.0.0.0", 8000):
        await asyncio.Future()  # run forever


if __name__ == "__main__":
    asyncio.run(main())
