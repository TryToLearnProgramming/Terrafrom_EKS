#===============EKS Node Group===============

resource "aws_eks_node_group" "eks-nodes-general" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "eks-${var.env}-nodes"
  node_role_arn   = aws_iam_role.eks-nodes-general-role.arn

  subnet_ids = [
    aws_subnet.eks-vpc-pub-sub1.id,
    aws_subnet.eks-vpc-pub-sub2.id
  ]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  ami_type             = "AL2_x86_64"
  capacity_type        = "ON_DEMAND"
  disk_size            = 30
  force_update_version = false
  instance_types       = ["t3a.medium"]

  tags = {
    Name = "eks-${var.env}-node"
  }

  labels = {
    role = "eks-nodes"
  }

  version = var.k8s-ver #K8s Version

  depends_on = [
    aws_iam_role_policy_attachment.eks-worker-node-policy-general,
    aws_iam_role_policy_attachment.eks-cni-policy-general,
    aws_iam_role_policy_attachment.eks-ec2-container-registry-read-only
  ]
}