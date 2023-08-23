
### how to use

to start server

```
docker-compose up --build --force-recreate --remove-orphans
```


to start client


```
pip install websockets asyncio
python src/test.py
```

| client infinitely polls two servers with random pause (1-5 sec.)


### requirements

- websockets
- asyncio

| tested using python3.9
