#!/usr/bin/env bash

uvicorn --workers=2 --no-access-log fastapi_app:app
