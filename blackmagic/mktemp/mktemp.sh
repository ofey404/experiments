TEMP_PATH=$(mktemp -d)
trap '{ rm -rf ${TEMP_PATH}; }' EXIT

echo $TEMP_PATH
echo "hello world" > $TEMP_PATH/hello.txt

echo '## ls $TEMP_PATH'
ls $TEMP_PATH

echo '## after this exits, run'
echo ls $TEMP_PATH
echo '## would return nothing'