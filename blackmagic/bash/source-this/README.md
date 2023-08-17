# script should only be sourced

[bash - How to define a shell script to be sourced not run - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/424492/how-to-define-a-shell-script-to-be-sourced-not-run)

```bash
./source_this.sh 
# Hey, you should source this script, not execute it!
source ./source_this.sh 
# Sourcing /home/ofey/experiments/blackmagic/bash/source-this/source_this.sh
```