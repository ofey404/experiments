import os
from feishu import API, RequestInput


def main():
    app_id = os.environ.get("FEISHU_APP_ID")
    secret = os.environ.get("FEISHU_APP_SECRET")
    print(f"app_id: {app_id}")
    print(f"secret: {secret}")


if __name__ == "__main__":
    main()
