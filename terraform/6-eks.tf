resource "aws_iam_role" "demo" {
  name = "eks-cluster-demo"

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
}

# allow eks control plane logging
resource "aws_iam_policy" "eks_control_plane_logs" {
  name        = "eks-control-plane-logs-policy"
  policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_control_plane_logs" {
  policy_arn = aws_iam_policy.eks_control_plane_logs.arn
  role       = aws_iam_role.demo.name
}

resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
}

resource "aws_eks_cluster" "demo" {
  name     = "demo"
  role_arn = aws_iam_role.demo.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private-us-east-1a.id,
      aws_subnet.private-us-east-1b.id,
      aws_subnet.private-us-east-1c.id,
      aws_subnet.public-us-east-1a.id,
      aws_subnet.public-us-east-1b.id,
      aws_subnet.public-us-east-1c.id
    ]
  }
#allow control-plane logging
    enabled_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]


      # send logs to CloudWatch
      cloudwatch_log_group_arn = aws_cloudwatch_log_group.eks_control_plane_logs.arn

  
  
  depends_on = [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy]
}
          }
  }


resource "aws_cloudwatch_log_group" "eks_control_plane_logs" {
  name = "/aws/eks/example/control-plane-logs"
}

output "create_aws_kubeconfig" {
value = "aws eks --region us-east-1 update-kubeconfig --name demo"
}
