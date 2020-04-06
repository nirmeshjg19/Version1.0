resource "aws_eks_cluster" "demo" {
  name     = var.cluster-name
  role_arn = aws_iam_role.app-eks-cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.app-cluster-sg.id]
    subnet_ids = flatten([aws_subnet.app-vpc-protected.*.id,aws_subnet.app-vpc-protected-1.*.id])
  }

  depends_on = [
    aws_iam_role_policy_attachment.app-eks-cluser1-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.app-eks-cluser1-AmazonEKSServicePolicy,
  ]
}


