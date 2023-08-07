#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

python -m pip install tos

source .env

python 1-list.py 

# generate presigned URL with {bucket key}
python 2-presign-generate.py test-sdk/2-presign-generate.txt

# upload with {file path} {presign url}
python 3-presign-upload.py README.md 'https://cloud-platform-manifests.tos-cn-beijing.volces.com/test-sdk/2-presign-generate.txt?X-Tos-Algorithm=TOS4-HMAC-SHA256&X-Tos-Credential=AKLTZWE5ZjZkMmRlNDFiNGIyYmIwMzAwMGRiZjNlNzQzM2Q%2F20230804%2Fcn-beijing%2Ftos%2Frequest&X-Tos-Date=20230804T022258Z&X-Tos-Expires=3600&X-Tos-SignedHeaders=host&X-Tos-Signature=814323390b1d1008c554c04b617798d80a20a0fa4d0e33ee7503a1faad7a815c'
