import boto3
import json
import os

print('Loading function')


def lambda_handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))
    # Create an EKS client
    eks = boto3.client('eks')

    # Call the list_clusters method to get the list of all EKS clusters in your account
    response = eks.list_clusters()

    # Print the list of EKS clusters
    for cluster in response['clusters']:
        print(cluster)

    cluster_name = 'cloud-platform-dev-cluster-ofey404'
    response = eks.list_nodegroups(clusterName=cluster_name)

    nodegroups = response['nodegroups']

    print("Nodegroups in EKS cluster {}: {}".format(cluster_name, nodegroups))

    nodegroup_name = nodegroups[0]

    nodegroup_config = eks.describe_nodegroup(clusterName=cluster_name, nodegroupName=nodegroup_name)['nodegroup']

    print("Nodegroup config: {}".format(nodegroup_config))

    print(os.environ.get('TEST', "1"))

    response = eks.update_nodegroup_config(clusterName=cluster_name,
                                           nodegroupName=nodegroup_name,
                                           scalingConfig={
                                               'minSize': 3,
                                               'desiredSize': 3,
                                           })
