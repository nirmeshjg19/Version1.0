resource "aws_iam_role" "app-eks-cluster-node" {
  name = "app-eks-cluster-node"

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

}

resource "aws_iam_role_policy_attachment" "app-eks-cluster-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.app-eks-cluster-node.name
}

resource "aws_iam_role_policy_attachment" "app-eks-cluster-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.app-eks-cluster-node.name
}

resource "aws_iam_role_policy_attachment" "app-eks-cluster-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.app-eks-cluster-node.name
}

resource "aws_iam_instance_profile" "app-eks-cluster-n" {
  name = "app-eks-cluster-n"
  role = aws_iam_role.app-eks-cluster-node.name
}

