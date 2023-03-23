import boto3
import datetime


def lambda_handler(event, context):

    eks_client = boto3.client('eks')

    # Get the current time in the timezone where the EKS cluster is running
    eks_timezone = eks_client.describe_cluster(name='my_eks_cluster')['cluster']['resourcesVpcConfig']['subnetIds'][0]
    current_time = datetime.datetime.now(tz=eks_timezone)

    # Check if current time is during non-business hours (defined as 6pm to 6am)
    business_start = current_time.replace(hour=6, minute=0, second=0, microsecond=0)
    business_end = current_time.replace(hour=18, minute=0, second=0, microsecond=0)
    if current_time < business_start and current_time > business_end:
        # Get the name of the nodegroup you want to scale down
        nodegroup_name = 'my_nodegroup'

        # Get the current configuration of the nodegroup
        nodegroup_config = eks_client.describe_nodegroup_config(clusterName='my_eks_cluster',
                                                                nodegroupName=nodegroup_name)['nodegroup']
        current_desired_size = nodegroup_config['scalingConfig']['desiredSize']
        if current_desired_size == nodegroup_config['scalingConfig']['minSize']:
            # Node group is already at minimum size
            return {'status': 'success', 'message': 'Node group is already at minimum size'}
        else:
            # Scale down the nodegroup to the minimum size
            response = eks_client.update_nodegroup_config(
                clusterName='my_eks_cluster',
                nodegroupName=nodegroup_name,
                scalingConfig={
                    'minSize': nodegroup_config['scalingConfig']['minSize'],
                    'desiredSize': nodegroup_config['scalingConfig']['minSize']
                })
            return {'status': 'success', 'message': 'Node group scaled down to minimum size'}
    else:
        # Not during non-business hours
        return {'status': 'success', 'message': 'Not during non-business hours'}
