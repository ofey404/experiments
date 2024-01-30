#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Example: Encrypt from CLI, decrypt in program

echo -n "Hello World" |  openssl rsautl -encrypt -pubin -inkey "./public_key.pem" | base64
# RtbtQkTmmoy62mQ02WnbPukINJv32j/6XQCW2ei+UI9ih/UleaGu/p4mqvdopjDM07hxkGPy9zXQ
# kL+at5Z6Mg87Ib2SuobMpyYWF0R1OKQW9XwsZiI0hCvoxfZJ6PoqH3JVqln+1qlrIIEy/dDWpxjY
# N8ZVWhldeFmPgSL3bGgM/eM17wgJtGSbksmrmZEgPcPj6TgGT+/3DuIHkc7DCAif99UcSa6DlEit
# IBe+4rFJD6Wm1/sn3r49/n7zcjJSebINbGoAsmaLFS6LmDcRwzNHSp9E6u6bY+9wNUJzW2MoSXFz
# PoGcP3Se52HzgpbXXNCouw3ykgEw15tlGICgdQ==

cat << EOF | go run ./decrypt/main.go
RtbtQkTmmoy62mQ02WnbPukINJv32j/6XQCW2ei+UI9ih/UleaGu/p4mqvdopjDM07hxkGPy9zXQ
kL+at5Z6Mg87Ib2SuobMpyYWF0R1OKQW9XwsZiI0hCvoxfZJ6PoqH3JVqln+1qlrIIEy/dDWpxjY
N8ZVWhldeFmPgSL3bGgM/eM17wgJtGSbksmrmZEgPcPj6TgGT+/3DuIHkc7DCAif99UcSa6DlEit
IBe+4rFJD6Wm1/sn3r49/n7zcjJSebINbGoAsmaLFS6LmDcRwzNHSp9E6u6bY+9wNUJzW2MoSXFz
PoGcP3Se52HzgpbXXNCouw3ykgEw15tlGICgdQ==
EOF
# Decrypted: Hello World
