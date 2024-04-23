#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# This experiment begins with a Hacker News post:
#
# Is .NET just miles ahead or am I delusional? (reddit.com)
# https://news.ycombinator.com/item?id=40021758
# 
# It says:
# > I just watched this video https://www.youtube.com/watch?v=zB9tEQYLPL4.
# > Appearantly go + htmx have managed to recreate razor or blazor templates and
# > people are gushing about how insane it is that they ALMOST make it typesafe.
# > Its not really typesafe, more like typescript where its autocomplete, but not
# > real.

# So I decide to find out what htmx is.
#
# https://semaphoreci.com/blog/htmx-react
#
# My Opinion: Simple and intuitive worth nothing, if its feature is limited.
#             HTMX only suitable for pure backend API project, when you need a simple test UI for it,
#             and you know you'll keep the code the same for 3 years.

# Besides, razor looks like yet another JSX:
# https://www.telerik.com/faqs/blazor-ui/what-is-the-difference-between-blazor-vs-razor
# <h1>
#     Hello @Model.FirstName
# </h1> 
# Razor takes care of rendering your HTML based on the data in your model, while also supporting various conditionals and loops.
