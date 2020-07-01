import asyncio
import time  # sync

from fastapi import FastAPI
from fastapi.middleware.wsgi import WSGIMiddleware

from flask_app import app as flask_app

app = FastAPI()

@app.get('/sync')
def sync():
    time.sleep(0.1)
    return 'ok'

@app.get('/async')
async def dummy():
    await asyncio.sleep(0.1)
    return 'ok'

# doesn't work because flask doesn't accept couroutines as a response type
#
# TypeError: The view function did not return a valid response. The return type must be a string, dict, tuple, Response instance, or WSGI callable, but it was a coroutine.
#
# @flask_app.route('/async')
# async def dummy2():
#     await asyncio.sleep(0.1)
#     return 'ok'

app.mount('/flask', WSGIMiddleware(flask_app))