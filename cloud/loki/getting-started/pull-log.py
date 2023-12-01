import requests
import json
import time

LOKI_QUERY = "http://localhost:3100/loki/api/v1/query_range?query={your_query_here}&start={start}&end={end}"

while True:
    start = int(time.time() * 1e9)  # convert to nanoseconds
    print("Sleep to wait for logs to be generated")
    time.sleep(3)  # wait for a while before querying to make sure we have some logs to fetch
    end = int(time.time() * 1e9)  # convert to nanoseconds

    query_url = LOKI_QUERY.format(your_query_here='{pod="simple-log-generator"}', start=start, end=end)
    response = requests.get(query_url)

    if response.status_code != 200:
        # handle error
        print("Error querying Loki: ", response.content)
    else:
        print(json.dumps(response.json(), indent=2))

