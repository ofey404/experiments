#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://docs.pydantic.dev/latest/concepts/pydantic_settings/


MY_AUTH_KEY=xxx MY_API_KEY=xxx python 1-settings.py
# {
#     'auth_key': 'xxx',
#     'api_key': 'xxx',
#     'redis_dsn': Url('redis://user:pass@localhost:6379/1'),
#     'pg_dsn': MultiHostUrl('postgres://user:pass@localhost:5432/foobar'),
#     'amqp_dsn': Url('amqp://user:pass@localhost:5672/'),
#     'special_function': math.cos,
#     'domains': set(),
#     'more_settings': {'foo': 'bar', 'apple': 1},
# }

# read from .env
python 2-dot-env.py 
# pydantic_core._pydantic_core.ValidationError: 1 validation error for Settings
# my_field_1
# ...

cd env-test/dev/
    python ../../2-dot-env.py 
    # {'my_field_1': 'this-is-env'}
cd -

cd env-test/prod/
    python ../../2-dot-env.py 
    # {'my_field_1': 'this-is-prod'}
cd -

# Env > .env[1] > .env[0]
cd env-test/override-order/
    python ../../2-dot-env.py 
    # {'my_field_1': 'this-is-prod'}
cd -

cd env-test/override-order/
    MY_FIELD_1='override-from-command-line' python ../../2-dot-env.py 
    # {'my_field_1': 'override-from-command-line'}
cd -