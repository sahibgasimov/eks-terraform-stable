resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# The following IAM Policy document allows ExternalDNS to update Route53 Resource Record Sets and Hosted Zones. 
#
#resource "aws_iam_policy" "external_dns_iam_policy" {
#  name = "ExternalDNSPolicy"
#  description = "The IAM Resources for External DNS"
#
#policy      = jsonencode({
#    "Version": "2012-10-17",
#    "Statement": [
#      {
#     #   "Effect": "Allow",
#        "Action": [
#          "route53:ChangeResourceRecordSets"
#        ],
#        "Resource": [
#          "arn:aws:route53:::hostedzone/*"
#        ]
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#          "route53:ListHostedZones",
#          "route53:ListResourceRecordSets"
#        ],
#        "Resource": [
#          "*"
#        ]
#      }
#    ]
#  })
#}
#
#resource "aws_iam_role_policy_attachment" "external_dns_iam_policy_attachment" {
#  policy_arn = aws_iam_policy.external_dns_iam_policy.arn
#  role       = aws_iam_role.nodes.name
#}
#



#allow nodes access to alb_controller
#Allow the creation of Service-Linked Roles for ELBs.
#Allow access to various EC2 resources, including instances, security groups, subnets, and network interfaces.
#Allow access to various resources related to ELBs, including load balancers, listeners, target groups, SSL policies, and rules.
#Allow access to various resources related to AWS Shield, AWS WAF, and ACM.
#Allow the creation and deletion of security groups, as well as the addition and removal of rules.
#Allow the creation of load balancers, target groups, listeners, and rules.
#Allow the addition and removal of tags from target groups and load balancers.
#resource "aws_iam_policy" "alb_controller_iam_policy" {
#  name        = "AlbControllerPolicy"
#  description = "The IAM policy for the ALB Controller"
#  policy      = jsonencode({
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Action": [
#                "iam:CreateServiceLinkedRole"
#            ],
#            "Resource": "*",
#            "Condition": {
#                "StringEquals": {
#                    "iam:AWSServiceName": "elasticloadbalancing.amazonaws.com"
#                }
#            }
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "ec2:DescribeAccountAttributes",
#                "ec2:DescribeAddresses",
#                "ec2:DescribeAvailabilityZones",
#                "ec2:DescribeInternetGateways",
#                "ec2:DescribeVpcs",
#                "ec2:DescribeVpcPeeringConnections",
#                "ec2:DescribeSubnets",
#                "ec2:DescribeSecurityGroups",
#                "ec2:DescribeInstances",
#                "ec2:DescribeNetworkInterfaces",
#                "ec2:DescribeTags",
#                "ec2:GetCoipPoolUsage",
#                "ec2:DescribeCoipPools",
#                "elasticloadbalancing:DescribeLoadBalancers",
#                "elasticloadbalancing:DescribeLoadBalancerAttributes",
#                "elasticloadbalancing:DescribeListeners",
#                "elasticloadbalancing:DescribeListenerCertificates",
#                "elasticloadbalancing:DescribeSSLPolicies",
#                "elasticloadbalancing:DescribeRules",
#                "elasticloadbalancing:DescribeTargetGroups",
#                "elasticloadbalancing:DescribeTargetGroupAttributes",
#                "elasticloadbalancing:DescribeTargetHealth",
#                "elasticloadbalancing:DescribeTags"
#            ],
#            "Resource": "*"
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "cognito-idp:DescribeUserPoolClient",
#                "acm:ListCertificates",
#                "acm:DescribeCertificate",
#                "iam:ListServerCertificates",
#                "iam:GetServerCertificate",
#                "waf-regional:GetWebACL",
#                "waf-regional:GetWebACLForResource",
#                "waf-regional:AssociateWebACL",
#                "waf-regional:DisassociateWebACL",
#                "wafv2:GetWebACL",
#                "wafv2:GetWebACLForResource",
#                "wafv2:AssociateWebACL",
#                "wafv2:DisassociateWebACL",
#                "shield:GetSubscriptionState",
#                "shield:DescribeProtection",
#                "shield:CreateProtection",
#                "shield:DeleteProtection"
#            ],
#            "Resource": "*"
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "ec2:AuthorizeSecurityGroupIngress",
#                "ec2:RevokeSecurityGroupIngress"
#            ],
#            "Resource": "*"
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "ec2:CreateSecurityGroup"
#            ],
#            "Resource": "*"
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "ec2:CreateTags"
#            ],
#            "Resource": "arn:aws:ec2:*:*:security-group/*",
#            "Condition": {
#                "StringEquals": {
#                    "ec2:CreateAction": "CreateSecurityGroup"
#                },
#                "Null": {
#                    "aws:RequestTag/elbv2.k8s.aws/cluster": "false"
#                }
#            }
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "ec2:CreateTags",
#                "ec2:DeleteTags"
#            ],
#            "Resource": "arn:aws:ec2:*:*:security-group/*",
#            "Condition": {
#                "Null": {
#                    "aws:RequestTag/elbv2.k8s.aws/cluster": "true",
#                    "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
#                }
#            }
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "ec2:AuthorizeSecurityGroupIngress",
#                "ec2:RevokeSecurityGroupIngress",
#                "ec2:DeleteSecurityGroup"
#            ],
#            "Resource": "*",
#            "Condition": {
#                "Null": {
#                    "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
#                }
#            }
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "elasticloadbalancing:CreateLoadBalancer",
#                "elasticloadbalancing:CreateTargetGroup"
#            ],
#            "Resource": "*",
#            "Condition": {
#                "Null": {
#                    "aws:RequestTag/elbv2.k8s.aws/cluster": "false"
#                }
#            }
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "elasticloadbalancing:CreateListener",
#                "elasticloadbalancing:DeleteListener",
#                "elasticloadbalancing:CreateRule",
#                "elasticloadbalancing:DeleteRule"
#            ],
#            "Resource": "*"
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "elasticloadbalancing:AddTags",
#                "elasticloadbalancing:RemoveTags"
#            ],
#            "Resource": [
#                "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
#                "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
#                "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
#            ],
#            "Condition": {
#                "Null": {
#                    "aws:RequestTag/elbv2.k8s.aws/cluster": "true",
#                    "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
#                }
#            }
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "elasticloadbalancing:AddTags",
#                "elasticloadbalancing:RemoveTags"
#            ],
#            "Resource": [
#                "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
#                "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
#                "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
#                "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*"
#            ]
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "elasticloadbalancing:AddTags"
#            ],
#            "Resource": [
#                "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
#                "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
#                "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
#            ],
#            "Condition": {
#                "StringEquals": {
#                    "elasticloadbalancing:CreateAction": [
#                        "CreateTargetGroup",
#                        "CreateLoadBalancer"
#                    ]
#                },
#                "Null": {
#                    "aws:RequestTag/elbv2.k8s.aws/cluster": "false"
#                }
#            }
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "elasticloadbalancing:ModifyLoadBalancerAttributes",
#                "elasticloadbalancing:SetIpAddressType",
#                "elasticloadbalancing:SetSecurityGroups",
#                "elasticloadbalancing:SetSubnets",
#                "elasticloadbalancing:DeleteLoadBalancer",
#                "elasticloadbalancing:ModifyTargetGroup",
#                "elasticloadbalancing:ModifyTargetGroupAttributes",
#                "elasticloadbalancing:DeleteTargetGroup"
#            ],
#            "Resource": "*",
#            "Condition": {
#                "Null": {
#                    "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
#                }
#            }
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "elasticloadbalancing:RegisterTargets",
#                "elasticloadbalancing:DeregisterTargets"
#            ],
#            "Resource": "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"
#        },
#        {
#            "Effect": "Allow",
#            "Action": [
#                "elasticloadbalancing:SetWebAcl",
#                "elasticloadbalancing:ModifyListener",
#                "elasticloadbalancing:AddListenerCertificates",
#                "elasticloadbalancing:RemoveListenerCertificates",
#                "elasticloadbalancing:ModifyRule"
#            ],
#            "Resource": [
#               "*" 
#            ]
#        }
#    ]  
#})
#}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}


resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2RoleforSSM" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = aws_iam_role.nodes.name
}
# giving nodes permission to access route53
resource "aws_iam_role_policy_attachment" "nodes-AmazonRoute53ReadOnlyAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53ReadOnlyAccess"
  role       = aws_iam_role.nodes.name
}
# giving nodes full permission to DynamoDB
resource "aws_iam_role_policy_attachment" "nodes-AmazonDynamoDBFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  role       = aws_iam_role.nodes.name
}

#resource "aws_iam_role_policy_attachment" "nodes-alb_controller_iam_policy" {
#  policy_arn = aws_iam_policy.alb_controller_iam_policy.arn
#  role       = aws_iam_role.nodes.name
#}

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn
  
  subnet_ids = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id,
    aws_subnet.private-us-east-1c.id
  ]

  lifecycle {
    create_before_destroy = true,
    # Allow external changes without Terraform plan difference
    ignore_changes = [scaling_config[0].desired_size]
  }
  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

  # taint {
  #   key    = "team"
  #   value  = "devops"
  #   effect = "NO_SCHEDULE"
  # }
  

   launch_template {
     name    = aws_launch_template.eks-with-disks.name
     version = aws_launch_template.eks-with-disks.latest_version
   }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.nodes-AmazonRoute53ReadOnlyAccess,
    aws_iam_role_policy_attachment.nodes-AmazonDynamoDBFullAccess,
   # aws_iam_role_policy_attachment.nodes-alb_controller_iam_policy
  ]
  

}

resource "aws_launch_template" "eks-with-disks" {
  name = "eks-with-disks"
  

}

# resource "aws_launch_template" "eks-with-disks" {
#   name = "eks-with-disks"

#   key_name = "local-provisioner"

#   block_device_mappings {
#     device_name = "/dev/xvdb"

#     ebs {
#       volume_size = 50
#       volume_type = "gp2"
#     }
#   }
# }


