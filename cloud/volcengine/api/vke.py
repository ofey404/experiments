import base64
import os
import random
import typing

from sign import API, RequestInput
import json
from dataclasses import dataclass


def list_clusters(api):
    resp = api.request(i=RequestInput(
        method="POST",
        action="ListClusters",
    ))
    print(f"Resp: {resp.json()}")
    return resp


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


def base64_string(s: str) -> str:
    return base64.b64encode(s.encode("utf-8")).decode("utf-8")


INIT_SCRIPT_BASE64_STRING = base64_string(f"""
wget https://cloud-platform-manifests.tos-cn-beijing.ivolces.com/cfs_mount.sh
chmod 774 cfs_mount.sh

VOLCENGINE_ACCESS_KEY={os.environ.get("VOLCENGINE_ACCESS_KEY")} \
VOLCENGINE_SECRET_KEY={os.environ.get("VOLCENGINE_SECRET_KEY")} \
CFS_FILESYSTEM_URI=cfs://{"disposable-230614"}.cfs-cn-beijing.ivolces.com \
CFS_CLIENT_NETWORK_SEGMENT=192.168.0.0/24 \
CFS_FILESYSTEM_NS_ID={"18014398509487398"} \
CFS_FILESYSTEM_UFS_PATH=tos://{"luchen-storage"}/ \
./cfs_mount.sh
""")


@dataclass
class CreateNodePoolInput:
    subnet_ids: typing.List[str]
    security_group_ids: typing.List[str]
    password: str


def create_node_pool(api: API, i: CreateNodePoolInput):
    resp = api.request(i=RequestInput(
        method="POST",
        action="CreateNodePool",
        body=json.dumps({
            "ClusterId": "cci3t4at5vb1613lal2hg",
            "Name": "disposable-cfs-auto-creation",
            "ClientToken": str(random.randint(0, 100000000000)),
            "NodeConfig": {
                "InstanceTypeIds": ["ecs.g3i.large"],
                "SubnetIds": i.subnet_ids,
                "SystemVolume": {
                    "Size": 40,
                    "Type": "ESSD_PL0"
                },
                "DataVolumes": [{
                    "Size": 100,
                    "Type": "ESSD_PL0"
                }],
                "InitializeScript": INIT_SCRIPT_BASE64_STRING,
                "Security": {
                    "Login": {
                        "SecurityGroupIds": i.security_group_ids,
                        "Password": base64_string(i.password),
                    }
                },
                "AdditionalContainerStorageEnabled": True,
            },
        }),
    ))

    print(f"Resp: {resp.json()}")
    return resp


def main():
    api = API(region="cn-beijing", service="vke", version="2022-05-12")

    list_clusters(api)
    # list_node_pools(api, i=ListNodePoolsInput())
    # create_node_pool(api, i=CreateNodePoolInput())


if __name__ == "__main__":
    main()
