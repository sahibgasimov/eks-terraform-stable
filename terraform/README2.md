## Building an EKS Cluster with ALB Ingress Controller and External DNS using Terraform

This tutorial will guide you through the process of building an Amazon Elastic Kubernetes Service (EKS) cluster using Terraform and deploying AWS ALB and External DNS. By the end of this tutorial, you will have a fully functional EKS cluster running in your AWS account and will be able to deploy applications using your own domain.

- External dns version = "6.14.3"
- Alb Ingress Controller Version = "1.4.8"
- Alb Ingress Tag = "v2.4.7"

Short instuction of the project.

## Table of Contents

- [Installation and Usage](#installation)
- [Create kubeconfig file](#documentation)
- [Deploying ALB Ingress Constroller and External DNS](#contributing)
- [Destroy](#destroy)

## Installation and Usage Example 
```
module "eks" {
source              =  "github.com/sahibgasimov/eks-terraform-stable//terraform?ref=main"
#### Cluster and Nodes ####
cluster_name    = "dev"
cluster_version = "1.24"
environment     = "dev"
instance_types  = "t3.small"
#autoscaling desired instance size 
desired_size    = 2
max_size        = 5
min_size        = 2
max_unavailable = 1
#### Route53 Domain ####
region         = "us-east-1"
domain         = "cmcloudlab1756.info"
hosted_zone_id = "Z045513210638OYC8T86B"
##### Networking #####
vpc_cidr         = "10.0.0.0/16"
private_subnet_1 = "10.0.0.0/19"
private_subnet_2 = "10.0.32.0/19"
private_subnet_3 = "10.0.128.0/19"
public_subnet_1  = "10.0.64.0/19"
public_subnet_2  = "10.0.96.0/19"
public_subnet_3  = "10.0.160.0/19"
}
```
Deploy module 
```
terraform init 
terraform apply
```

## Create kubeconfig file

```
aws eks --region us-east-1 update-kubeconfig --name your_cluster_name
kubectl get nodes
kubectl get pods -n kube-system #Check if the controller is running.
```

## Destroy

```
terraform destroy
```

