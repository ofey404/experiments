from sign import API, RequestInput


def main():
    api = API(
        region="cn-beijing",
        service="cfs",
        version="2022-02-02",
    )

    resp = api.request(i=RequestInput(
        method="Get",
        action="ListFs",
    ))

    print(f"Resp: {resp.json()}")


if __name__ == "__main__":
    main()
