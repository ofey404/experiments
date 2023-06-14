import typing

from sign import API, RequestInput
import json
from dataclasses import dataclass


@dataclass
class ListNodePoolsInput:
    cluster_ids: typing.List[str]


def list_node_pools(api: API, i: ListNodePoolsInput):
    resp = api.request(i=RequestInput(
        method="POST", action="ListNodePools", body=json.dumps({
            "Filter": {
                "ClusterIds": i.cluster_ids
            },
        })))

    print(f"Resp: {resp.json()}")
    return resp


def main():
    api = API(region="cn-beijing", service="vke", version="2022-05-12")

    # list_clusters(api)
    # list_node_pools(api, i=ListNodePoolsInput())


def list_clusters(api):
    resp = api.request(i=RequestInput(
        method="POST",
        action="ListClusters",
    ))
    print(f"Resp: {resp.json()}")
    return resp


if __name__ == "__main__":
    main()
