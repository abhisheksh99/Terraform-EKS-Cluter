# Creating role for the EKS cluster
resource "aws_iam_role" "eks-cluster-role" {
    # The name of the role
    name = "eks-cluster-role"

    # Define who can assume this role
    # The policy that grants an entity permission to assume the role
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

    tags = {
      Name = "eks-cluster-role"
    }
}

# Attach necessary policies to the EKS cluster role
resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
    # The ARN of the policy you want to apply
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    # The role the policy should be applied to
    role = aws_iam_role.eks-cluster-role.name
}

# EKS cluster resource
resource "aws_eks_cluster" "eks" {
    # Name of the EKS cluster
    name = "eks"

    # IAM role for the EKS cluster to assume
    role_arn = aws_iam_role.eks-cluster-role.arn

    # Kubernetes version to use for the cluster
    # You should specify a version, e.g., "1.21"
    version = "1.21"

    # VPC configuration for the cluster
    vpc_config {
      # Whether the cluster's API server is accessible only within the VPC
      endpoint_private_access = false
      # Whether the cluster's API server is accessible from the internet
      endpoint_public_access = true

      # Subnets in which to place the EKS cluster
      # Make sure to use the correct resource references
      subnet_ids = [
        aws_subnet.main-pub-sub-1.id,
        aws_subnet.main-pub-sub-2.id,
        aws_subnet.main-pri-sub-1.id,
        aws_subnet.main-pri-sub-2.id
      ]
    }

    # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
    # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
    depends_on = [
      aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy
    ]
}