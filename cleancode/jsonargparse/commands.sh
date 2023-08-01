#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

pip install jsonargparse[all]==4.23.0

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


python 4-attribute-docstring.py -h
# usage: 4-attribute-docstring.py [-h] [--config CONFIG] [--print_config[=flags]] [--options CONFIG] --options.name NAME [--options.residence CONFIG]
#                                 --options.residence.city CITY --options.residence.email EMAIL [--options.prize PRIZE] [--options.metadata METADATA]
# 
# Prints the prize won by a person.
# 
# options:
#   -h, --help            Show this help message and exit.
#   --config CONFIG       Path to a configuration file.
#   --print_config[=flags]
#                         Print the configuration after applying all other arguments and exit. The optional flags customizes the output and are one or more
#                         keywords separated by comma. The supported flags are: comments, skip_default, skip_null.
# 
# Options for a competition winner:
#   --options CONFIG      Path to a configuration file.
#   --options.name NAME   Name of winner. (required, type: str)
#   --options.prize PRIZE
#                         Amount won. (type: int, default: 100)
#   --options.metadata METADATA
#                         Metadata is a optional nested option. (type: Optional[OptionalNestedOptions], default: null)
# 
# Residence is a nested option:
#   --options.residence CONFIG
#                         Path to a configuration file.
#   --options.residence.city CITY
#                         City of winner. (required, type: str)
#   --options.residence.email EMAIL
#                         Email of winner. (required, type: str)
