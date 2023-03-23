import boto3
import os

# constants
ENV_FLAG_MODE = "MODE"

MODE_UP = "up"
MODE_DOWN = "DOWN"
MODES = [
    MODE_UP,
    MODE_DOWN,
]

CLUSTER_NAME_PREFIX = "cloud-platform-dev-cluster-ofey404"

# global variables
eks = None


def lambda_handler(event, context):
    try:
        global eks
        eks = boto3.client("eks")
        # Create an EKS client
        # prefix = "cloud-platform-dev-cluster-"
        clusters = list_clusters(CLUSTER_NAME_PREFIX)

        mode = get_mode()
        resize_clusters(clusters, mode)
    except Exception as e:
        # send to feishu
        print(e)
        raise e


# get_mode returns the mode from the environment variable MODE,
# or raises an exception if it's not set or not a valid mode.
def get_mode():
    try:
        mode = os.environ[ENV_FLAG_MODE]
    except KeyError:
        raise Exception("Environment variable {} is not set, should be among {}".format(ENV_FLAG_MODE, MODES))
    if mode not in MODES:
        raise Exception("Environment variable {} is set to {}, should be among {}".format(ENV_FLAG_MODE, mode, MODES))
    return mode


def list_clusters(prefix=None):
    response = eks.list_clusters()
    clusters = response["clusters"]
    if prefix:
        clusters = [c for c in clusters if c.startswith(prefix)]
    return clusters


def list_nodegroups(cluster_name):
    response = eks.list_nodegroups(clusterName=cluster_name)
    nodegroups = response["nodegroups"]
    return nodegroups


def get_nodegroup_maxsize(cluster_name, nodegroup_name):
    nodegroup_config = eks.describe_nodegroup(clusterName=cluster_name, nodegroupName=nodegroup_name)["nodegroup"]

    return nodegroup_config["scalingConfig"]["maxSize"]


# resize_clusters resizes all nodegroups in all clusters:
# - MODE_UP: to the maximum size
# - MODE_DOWN: to 0
def resize_clusters(clusters, mode):
    for cluster_name in clusters:
        nodegroups = list_nodegroups(cluster_name)

        for nodegroup_name in nodegroups:
            if mode == MODE_UP:
                to_size = get_nodegroup_maxsize(cluster_name, nodegroup_name)
            elif mode == MODE_DOWN:
                to_size = 0

            response = eks.update_nodegroup_config(
                clusterName=cluster_name,
                nodegroupName=nodegroup_name,
                scalingConfig={
                    "minSize": to_size,
                    "desiredSize": to_size,
                },
            )

            errors = response["update"]["errors"]

            if len(errors) > 0:
                raise Exception("Error updating nodegroup config: {}".format(errors))
