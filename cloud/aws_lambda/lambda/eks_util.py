def list_clusters(eks, prefix=None):
    response = eks.list_clusters()
    clusters = response["clusters"]
    if prefix:
        clusters = [c for c in clusters if c.startswith(prefix)]
    return clusters


class ClusterScaler:

    def __init__(self, eks, cluster_name):
        self.eks = eks
        self.cluster_name = cluster_name

    def scale_to_max(self):
        nodegroups = self.list_nodegroups()

        for nodegroup_name in nodegroups:
            max_size = self.get_nodegroup_maxsize(nodegroup_name)
            self._scale(nodegroup_name, max_size)

    def scale_to_zero(self):
        nodegroups = self.list_nodegroups()

        for nodegroup_name in nodegroups:
            self._scale(nodegroup_name, 0)

    def _scale(self, nodegroup_name, to_size):
        print("Resizing nodegroup {}".format(nodegroup_name))

        print("Resizing to {}".format(to_size))

        response = self.eks.update_nodegroup_config(
            clusterName=self.cluster_name,
            nodegroupName=nodegroup_name,
            scalingConfig={
                "minSize": to_size,
                "desiredSize": to_size,
            },
        )

        errors = response["update"]["errors"]

        if len(errors) > 0:
            raise Exception("Error updating nodegroup config: {}".format(errors))

        print("Nodegroup config updated")

    def get_nodegroup_maxsize(self, nodegroup_name):
        nodegroup_config = self.eks.describe_nodegroup(clusterName=self.cluster_name,
                                                       nodegroupName=nodegroup_name)["nodegroup"]

        return nodegroup_config["scalingConfig"]["maxSize"]

    def list_nodegroups(self):
        response = self.eks.list_nodegroups(clusterName=self.cluster_name)
        nodegroups = response["nodegroups"]
        return nodegroups
