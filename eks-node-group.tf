# Creating IAM role for EKS worker nodes
resource "aws_iam_role" "eks-node-general" {
    # The name of the role
    name = "eks-node-general"

    # Define who can assume this role
    # The policy that grants an entity permission to assume the role
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"  
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

    tags = {
      Name = "eks-node-role"  # Tag for easier identification of the role
    }
}

# Attach necessary policies to the EKS node role

# AmazonEKSWorkerNodePolicy provides permissions for EKS worker nodes
resource "aws_iam_role_policy_attachment" "eks-node-AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.eks-node-general.name
}

# AmazonEKS_CNI_Policy allows EKS worker nodes to connect to EKS Clusters
resource "aws_iam_role_policy_attachment" "eks-node-AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.eks-node-general.name
}

# AmazonEC2ContainerRegistryReadOnly allows EKS workers to pull images from ECR
resource "aws_iam_role_policy_attachment" "eks-node-AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.eks-node-general.name
}

# EKS Node Group
resource "aws_eks_node_group" "general" {
    cluster_name    = aws_eks_cluster.eks.name  # Name of the EKS cluster
    node_group_name = "general"                   # Name of the node group
    node_role_arn   = aws_iam_role.eks-node-general.arn  # IAM role for the nodes

    # Subnets to launch nodes in for worker nodes only load balancers will be deployed in public subnets
    subnet_ids = [
        aws_subnet.main-pri-sub-1.id,  # Private subnet 1
        aws_subnet.main-pri-sub-2.id   # Private subnet 2
    ]

    scaling_config {
        desired_size = 2   # Desired number of nodes in the group
        max_size     = 3   # Maximum number of nodes in the group
        min_size     = 1   # Minimum number of nodes in the group
    }

    # Type of EC2 instances to launch for the node group
    instance_types = ["t3.small"]

    # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
    depends_on = [
        aws_iam_role_policy_attachment.eks-node-AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.eks-node-AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.eks-node-AmazonEC2ContainerRegistryReadOnly,
    ]

    tags = {
        Name = "EKS-general-node-group"  # Tag for easier identification of the node group
    }
}