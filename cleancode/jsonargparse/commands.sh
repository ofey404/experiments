#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

pip install jsonargparse==4.23.0 pydantic

python 1-parser.py 
# usage: 1-parser.py [-h] [--config CONFIG] [--print_config[=flags]] [--prize PRIZE] name
# 1-parser.py: error: Configuration check failed :: Key "name" is required but not included in config object or its value is None.

python 1-parser.py -h
# usage: 1-parser.py [-h] [--config CONFIG] [--print_config[=flags]] [--prize PRIZE] name
# 
# <function command at 0x7f5251e07d90>
# 
# positional arguments:
#   name                  (required, type: str)
# 
# options:
#   -h, --help            Show this help message and exit.
#   --config CONFIG       Path to a configuration file.
#   --print_config[=flags]
#                         Print the configuration after applying all other arguments and exit. The optional flags customizes the output and are one or
#                         more keywords separated by comma. The supported flags are: comments, skip_default, skip_null.
#   --prize PRIZE         (type: int, default: 100)

python 1-parser.py --config 1-parser.yaml 
# fromYaml won 404€!

python 1-parser.py --config 1-parser.yaml overrideFromShell
# overrideFromShell won 404€!

python 1-parser.py --config 1-parser.yaml overrideFromShell --prize 10000
# overrideFromShell won 10000€!

python 2-nested.py --config 2-nested.yaml 
# fromNestedYaml won 404€!
# Contact info: Contact(city='mountainView', email='noreply@gmail.com', phone=['1234567890', '0987654321'])

python 2-nested.py --help
# /home/ofey/.local/lib/python3.10/site-packages/pydantic/_migration.py:283: UserWarning: `pydantic.utils:Representation` has been removed. We are importing from `pydantic.v1.utils:Representation` instead.See the migration guide for more details: https://docs.pydantic.dev/latest/migration/
#   warnings.warn(
# usage: 2-nested.py [-h] [--config CONFIG] [--print_config[=flags]] [--contact CONFIG] --contact.city CITY --contact.email EMAIL
#                    --contact.phone PHONE [--contact.meta CONFIG] --contact.meta.m1 M1 [--prize PRIZE]
#                    name
# 
# Prints the prize won by a person.
# 
# positional arguments:
#   name                  Name of winner. (required, type: str)
# 
# options:
#   -h, --help            Show this help message and exit.
#   --config CONFIG       Path to a configuration file.
#   --print_config[=flags]
#                         Print the configuration after applying all other arguments and exit. The optional flags customizes the output and are one or
#                         more keywords separated by comma. The supported flags are: comments, skip_default, skip_null.
#   --prize PRIZE         Amount won. (type: int, default: 100)
# 
# Contact(city: str, email: str, phone: List[str], meta: __main__.Meta):
#   --contact CONFIG      Path to a configuration file.
#   --contact.city CITY   (required, type: str)
#   --contact.email EMAIL
#                         (required, type: str)
#   --contact.phone PHONE, --contact.phone+ PHONE
#                         (required, type: List[str])
# 
# Meta(m1: str):
#   --contact.meta CONFIG
#                         Path to a configuration file.
#   --contact.meta.m1 M1  (required, type: str)

