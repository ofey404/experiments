import boto3
import os
from eks_util import ClusterScaler, list_clusters
from feishu import MessagePusher

# constants
ENV_FLAG_MODE = "MODE"
ENV_FEISHU_APP_ID = "FEISHU_APP_ID"
ENV_FEISHU_APP_SECRET = "FEISHU_APP_SECRET"

MODE_UP = "up"
MODE_DOWN = "DOWN"
MODES = [
    MODE_UP,
    MODE_DOWN,
]

# filter clusters by prefix
CLUSTER_NAME_PREFIX = "cloud-platform-dev-cluster-ofey404"


# lambda_handler is the entry point
def lambda_handler(event, context):
    try:
        eks = boto3.client("eks")
        # Create an EKS client
        # prefix = "cloud-platform-dev-cluster-"
        clusters = list_clusters(eks, CLUSTER_NAME_PREFIX)
        print("Clusters: {}".format(clusters))

        mode = get_mode()
        print("Mode: {}".format(mode))

        pusher = MessagePusher(
            os.environ[ENV_FEISHU_APP_ID],
            os.environ[ENV_FEISHU_APP_SECRET],
        )
    except Exception as e:
        # send to feishu
        print("Exception during initialization: {}".format(e))
        raise e

    for cluster_name in clusters:
        try:
            print("Resizing cluster {}".format(cluster_name))

            scaler = ClusterScaler(eks, cluster_name)
            if mode == MODE_UP:
                scaler.scale_to_max()
            elif mode == MODE_DOWN:
                scaler.scale_to_zero()
        except Exception as e:
            pusher.push_error(e)
            continue


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
