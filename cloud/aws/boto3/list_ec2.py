import boto3

# Create an EC2 client
ec2 = boto3.client('ec2')

# Call describe_instances(), which returns a dictionary
response = ec2.describe_instances(Filters=[
    {
        'Name': 'instance-type',
        'Values': ['g*',],
    },
],)

instance_ids = []
for reservation in response['Reservations']:
    for instance in reservation['Instances']:
        instance_ids.append(instance['InstanceId'])

# Terminate the instances
if instance_ids:
    ec2.terminate_instances(InstanceIds=instance_ids)
    print(f"Terminated instances: {instance_ids}")
    # TODO: notification
else:
    print("No instances found with tag Name starting with g")
    # TODO: notification too
