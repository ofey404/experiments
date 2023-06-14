import requests
import os


def main():
    ak = os.environ.get('VOLCENGINE_ACCESS_KEY')
    sk = os.environ.get('VOLCENGINE_SECRET_KEY')
    print(ak)
    print(sk)

    # Set up the API endpoint URL and parameters
    # url = "https://open.volcengineapi.com"
    url = "http://localhost:8000"
    action = "xxx"
    version = "2022-02-02"
    params = {"param1": "value1", "param2": "value2"}

    # Send the API request with the parameters
    response = requests.get(f"{url}?Action={action}&Version={version}", params=params)

    # Raise an exception if the API request failed
    response.raise_for_status()

    # Print the response content
    print("API request successful!")
    print(response.content)


if __name__ == "__main__":
    main()
