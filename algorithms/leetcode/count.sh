#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

# filter {serial number}-{solution name}.go by unique serial number

# Get counts
recently_updated=$(find . -name '*.go' -mtime -1 | sed -E 's/.*\/([0-9]+)-.*\.go/\1/' | sort -u | wc -l)
updated_in_week=$(find . -name '*.go' -mtime -7 | sed -E 's/.*\/([0-9]+)-.*\.go/\1/' | sort -u | wc -l)
updated_in_month=$(find . -name '*.go' -mtime -30 | sed -E 's/.*\/([0-9]+)-.*\.go/\1/' | sort -u | wc -l)
all_solved=$(find . -name '*.go' | sed -E 's/.*\/([0-9]+)-.*\.go/\1/' | sort -u | wc -l)

# Print as a table
printf "| %-30s | %-10s |\n" "Category" "Count"
printf "| %-30s | %-10s |\n" "------------------------------" "----------"
printf "| %-30s | %-10d |\n" "Problems updated in 1 day" $recently_updated
printf "| %-30s | %-10d |\n" "Problems updated in 1 week" $updated_in_week
printf "| %-30s | %-10d |\n" "Problems updated in 1 month" $updated_in_month
printf "| %-30s | %-10d |\n" "All problems solved" $all_solved
