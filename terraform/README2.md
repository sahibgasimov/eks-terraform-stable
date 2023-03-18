# Building an EKS Cluster with ALB Ingress Controller and External DNS using Terraform

[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/sahibgasimov/eks-terraform-stable/blob/master/LICENSE)

This tutorial will guide you through the process of building an Amazon Elastic Kubernetes Service (EKS) cluster using Terraform and deploying AWS ALB and External DNS. By the end of this tutorial, you will have a fully functional EKS cluster running in your AWS account and will be able to deploy applications using your own domain.

# Project Name

[![Build Status](https://img.shields.io/travis/user/repo.svg?style=flat-square)](https://travis-ci.org/user/repo)
[![Coverage Status](https://img.shields.io/coveralls/user/repo.svg?style=flat-square)](https://coveralls.io/github/user/repo?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/user/repo/blob/master/LICENSE)

Short description of the project.

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

<<<<<<< HEAD
For more detailed instruction please check the article.
=======
For more detailed instruction please check the article.
>>>>>>> 3cccb23dc596b48d10e4d713e3daf06786adacd9
