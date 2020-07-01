from time import sleep

from flask import Flask

app = Flask(__name__)

@app.route('/sync')
def hello():
    sleep(0.1)
    return 'ok'
