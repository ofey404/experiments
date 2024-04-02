#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://github.com/streamlit/streamlit

pip install streamlit==1.32.0  # for write_stream
streamlit hello

streamlit run simple_app.py

# code extracted from hello application
streamlit run hello/1_animation_demo.py
streamlit run hello/2_plotting_demo.py
streamlit run hello/3_mapping_demo.py 
streamlit run hello/4_dataframe_demo.py 

streamlit run conversational_app.py 
