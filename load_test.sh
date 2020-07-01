#!/usr/bin/env bash
set -xeu

DURATION="30s"
LOAD_WORKERS="2"

# check the sync endpoint
URL="http://localhost:8000/sync"
if http --check-status --pretty=none GET $URL > /dev/null 2>&1 ; then
    hey -z=$DURATION -cpus=$LOAD_WORKERS $URL
fi

# check the async endpoint
URL="http://localhost:8000/async"
if http --check-status --pretty=none GET $URL > /dev/null 2>&1 ; then
    hey -z=$DURATION -cpus=$LOAD_WORKERS $URL
fi

# check the sync-inside-flask endpoint
URL="http://localhost:8000/flask/sync"
if http --check-status --pretty=none GET $URL > /dev/null 2>&1 ; then
    hey -z=$DURATION -cpus=$LOAD_WORKERS $URL
fi

# check the async-inside-flask endpoint
URL="http://localhost:8000/flask/async"
if http --check-status --pretty=none GET $URL > /dev/null 2>&1 ; then
    hey -z=$DURATION -cpus=$LOAD_WORKERS $URL
fi