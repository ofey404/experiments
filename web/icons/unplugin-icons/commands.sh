#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://github.com/unplugin/unplugin-icons

# click `unplugin icons`
# https://icon-sets.iconify.design/
# https://icones.js.org/

# unplugin-icons package for Webpack compiler
npm i -D unplugin-icons

# @iconify/json package for the icons collection
npm i -D @iconify/json

# @svgr/core and @svgr/plugin-jsx packages for React compatibility
npm i -D @svgr/core @svgr/plugin-jsx

# see: https://www.launchfa.st/blog/nextjs-unplugin-icons
# edit next.config.mjs
# edit tsconfig.json