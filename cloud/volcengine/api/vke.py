from sign import API, RequestInput


def main():
    api = API(region="cn-beijing", service="vke", version="2022-05-12")

    resp = api.request(i=RequestInput(
        method="POST",
        action="ListClusters",
    ))

    print(f"Resp: {resp.json()}")


if __name__ == "__main__":
    main()
