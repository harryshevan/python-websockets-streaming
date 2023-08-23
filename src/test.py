from random import randint

import asyncio
import websockets

SERVER_ADDRESS = "0.0.0.0"
SERVER_PORT_1 = "8002"
SERVER_PORT_2 = "8003"


async def send_to_client(msg: str, ip: str, port: str):
    uri = f"ws://{ip}:{port}"
    async with websockets.connect(uri) as websocket:
        await websocket.send(msg)
        print(f">>> {msg}")
        response = await websocket.recv()
        print(f"<<< {response}")


async def infinite_polling(msg: str, ip: str, port: str):
    cnt = 0
    while True:
        await send_to_client(f"{cnt} {msg}", ip, port)
        await asyncio.sleep(randint(1, 5))
        cnt += 1


async def main():
    await asyncio.gather(
        infinite_polling("Russia", SERVER_ADDRESS, SERVER_PORT_1),
        infinite_polling("China", SERVER_ADDRESS, SERVER_PORT_2),
    )


if __name__ == "__main__":
    asyncio.run(main())
