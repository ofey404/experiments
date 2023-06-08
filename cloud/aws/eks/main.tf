terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.47"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

data "aws_eks_cluster" "this" {
  name = module.eks_blueprints.eks_cluster_id
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks_blueprints.eks_cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.this.token
}

module "eks_blueprints" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.25.0"

  cluster_name    = "kubeflow-manifest-test-disposable-230607"
  cluster_version = "1.23"

  vpc_id             = var.vpc_name
  private_subnet_ids = var.private_subnet_ids

  iam_role_additional_policies = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  managed_node_groups = {
    basic = {
      node_group_name = "basic-node-set"
      instance_types  = [
        "t2.large"
      ]
      min_size     = 3
      max_size     = 3
      desired_size = 3
      subnet_ids   = var.private_subnet_ids
    }
  }
}
