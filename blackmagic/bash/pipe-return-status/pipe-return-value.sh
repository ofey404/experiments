(echo "test return value in pipie" && exit 2) 2>&1 | tee output.txt; echo ${PIPESTATUS[0]}
