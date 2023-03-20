## Building an EKS Cluster with ALB Ingress Controller and External DNS using Terraform


This tutorial will guide you through the process of building an Amazon Elastic Kubernetes Service (EKS) cluster using Terraform and deploying AWS ALB and External DNS. By the end of this tutorial, you will have a fully functional EKS cluster running in your AWS account and will be able to deploy applications using your own domain.


- external_dns_version = "6.14.3"
- alb_ingress_controller_version = "1.4.8"
- alb_ingress_tag = "v2.4.7"
Short instuction of the project.

## Table of Contents

- [Installation and Usage](#installation)
- [Create kubeconfig file](#documentation)
- [Deploying ALB Ingress Constroller and External DNS](#contributing)
- [Destroy](#destroy)

## Installation and Usage

```
git clone https://github.com/sahibgasimov/eks-terraform-stable.git
cd /terraform/module
terraform init 
terraform apply
```

## Create kubeconfig file

```
aws eks --region us-east-1 update-kubeconfig --name your_cluster_name
kubectl get nodes

```
## Deploying ALB Ingress controller and External DNS

```
mv ../helm.tf .
terraform init 
terraform apply
```

## Destroy

```
terraform destroy
```

