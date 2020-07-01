# Flask in FastAPI

FastAPI is a new web framework, similar to Flask, with significant performance benefits thanks to asynchronous Python.
According to [this](https://fastapi.tiangolo.com/advanced/wsgi/) page, it is possible to run an existing Flask application *inside* of a FastAPI application, supporting a gradual migration.
That sounds dandy, but I have some questions:

1. [x] In this setup, can we `async def` the handler for a *Flask* endpoint?
2. [x] Are there performance benefits without making any changes? I.e. does a synchronous endpoint in Flask suddenly become faster inside of Uvicorn, compared to Gunicorn?


## 1

Hard no.
Flask handlers need to return something that can be turned into a `flask.Response` object.
Coroutines cannot.

## 2

The full load test results can be seen in the `results` directory, but a quick snippet is here.
At a surface level, the answer appears to be yes.
More requests went through the FastAPI solution, and the latency histogram is better.

## Flask inside of Gunicorn

```
Summary:
  Total:        30.7985 secs
  Slowest:      0.8277 secs
  Fastest:      0.1054 secs
  Average:      0.6344 secs
  Requests/sec: 77.7310
  
  Total data:   4788 bytes
  Size/request: 2 bytes

Response time histogram:
  0.105 [1]     |
  0.178 [7]     |
  0.250 [8]     |
  0.322 [8]     |
  0.394 [0]     |
  0.467 [301]   |■■■■■■■■■■■■■■
  0.539 [886]   |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  0.611 [0]     |
  0.683 [4]     |
  0.755 [297]   |■■■■■■■■■■■■■
  0.828 [882]   |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
```

### Flask inside of FastAPI inside of Uvicorn

```
Summary:
  Total:        30.2374 secs
  Slowest:      0.3229 secs
  Fastest:      0.1078 secs
  Average:      0.2103 secs
  Requests/sec: 236.5946
  
  Total data:   14308 bytes
  Size/request: 2 bytes

Response time histogram:
  0.108 [1]     |
  0.129 [1799]  |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  0.151 [0]     |
  0.172 [0]     |
  0.194 [1772]  |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  0.215 [23]    |
  0.237 [1183]  |■■■■■■■■■■■■■■■■■■■■
  0.258 [0]     |
  0.280 [0]     |
  0.301 [2366]  |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  0.323 [10]    |
```

## Disclaimer

These load tests are really just toys, not representative of an actual web app.
