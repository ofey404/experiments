#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# -u for web page, you can use jina to extract markdown.
ask --url https://r.jina.ai/https://paulgraham.com/goodtaste.html "summarize it"
# The article discusses the concept of good taste in art and argues that good
# taste does exist. The author presents a reductio ad absurdum argument to show
# that if there is no good taste, then there can be no good art or skilled
# artists. The article explains that good taste is not solely based on
# popularity or subjective opinions, but rather on the ability of art to affect
# and resonate with its audience. It concludes that while perfect taste may not
# be attainable, having good taste is possible through informed and thoughtful
# judgment.

# -c for command only
ask --command "get git logs first line only"
# git log --pretty=format:"%h %s" -1

# -s for web search
# Don't use. Take a long time.
ask --search "how to delete a docker image"
# To delete a Docker image, you can follow these steps:
# ...

# -r to reply previous answer
ask -r "delete last 30 days"
# To delete Docker images that were created in the last 30 days, you can use a combination of Docker commands and shell commands.
# ...