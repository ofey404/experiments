#!/bin/bash

# merge files line by line, remove duplicates

# Ensure the files exist
for f in old_file old_file2; do
    if [ ! -f "$f" ]; then
        echo "file does not exist: $f"
        exit 1
    fi
done

# Merge keys, remove duplicates, and overwrite the old keys file
# The <(echo) command adds a newline between the contents of old_file and old_file2.
cat old_file <(echo) old_file2 | sort -u > old_file_tmp && mv old_file_tmp new_file

echo "Keys merged successfully"
echo "Content in new_file:"
cat new_file
