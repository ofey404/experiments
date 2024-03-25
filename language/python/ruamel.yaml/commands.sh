#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Doc:
# https://yaml.readthedocs.io/en/latest/

python 1-dump-comment.py 
# Type of data = <class 'ruamel.yaml.comments.CommentedMap'>
# 
# Content after removing 'foz' key:
# # Our app configuration
# 
# foo: bar
# # foo is our main variable
# 
# opt1: foqz
# # And finally we have our optional configs.
# # These are not really mandatory, they can be
# # considere as "would be nice".

python 2-build-comment-map.py 
# # This is a comment for the whole data structure
# # Before the 'entry' key
# entry: foo  # This is an EOL comment
# # Before the 'dict' key
# dict:
#   # After the 'dict' key
#   foo: bar
#   bar: baz
# # This is a multi-line comment,
# # before the 'list' key.
# list:
#   # This is a multi-line comment,
#   # after the 'list' key.
# - foo
# - bar
# - baz
# nested:
#   entry: foo  # CommentedMap could be nested
# # Before dict
#   dict:
#   # After dict
#     foo: bar

python 3-class-serialization.py 
# entry: foo
# dict_entry:
#   foo: bar
#   bar: baz
# list_entry:
# - 1
# - 2
# - 3
# nested_entry:
#   entry: foo
#   dict_entry:
#     foo: bar

python 4-parse-comment.py 
# entry: foo
# dict_entry:
#   foo: bar
#   bar: baz
# # comment before list
# list_entry:
# - 1
# - 2
# - 3
# nested_entry:
#   entry: foo  # nested EOL comment
#   dict_entry:
#   # nested comment after dict
#     foo: bar
