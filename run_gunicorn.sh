#!/usr/bin/env bash

gunicorn -w=2 --threads=4 flask_app:app
