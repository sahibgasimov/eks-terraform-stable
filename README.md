## Building an EKS Cluster with ALB Ingress Controller and External DNS using Terraform

This tutorial will guide you through the process of building an Amazon Elastic Kubernetes Service (EKS) cluster using Terraform and deploying AWS ALB and External DNS. By the end of this tutorial, you will have a fully functional EKS cluster running in your AWS account and will be able to deploy applications using your own domain.
![alt text](https://github.com/sahibgasimov/eks-terraform-stable/blob/main/alb_ingress_controller.jpg)

Short instuction of the project.

## Table of Contents

- [Installation and Usage](#installation)
- [Create kubeconfig file](#documentation)
- [Deploying ALB Ingress Constroller and External DNS](#contributing)
- [Destroy](#destroy)
- [Application Deployment](#application)
- [Annotations](#annotations)

## Installation and Usage Example 

Configure AWS Credentials 

```
aws configure --profile acg
export AWS_PROFILE=acg
aws sts get-caller-identity 

or

export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""

```

```
module "eks" {
  source = "github.com/sahibgasimov/eks-terraform-stable//terraform?ref=main" 
  #### EKS Cluster ####
  cluster_name    = "dev"
  cluster_version = "1.28"
  environment     = "dev"
  ##### ALB Ingress Controller and External DNS #####
  external_dns          = "6.28.5"
  alb_ingress           = "1.6.1"
  alb_ingress_image_tag = "v2.6.1"
  csi_driver = "v1.26.0-eksbuild.1"
  ##### Nodes Autoscaling desired instance size #####
  instance_types  = "t3.small"
  desired_size    = 2
  max_size        = 5
  min_size        = 2
  max_unavailable = 1
  ##### Route53 Domain #####
  region         = "us-east-1"
  domain         = "34908534.realhaonlabs.net"
  hosted_zone_id = "Z10013141223FS3VGI9"
  ##### Networking #####
  vpc_cidr         = "10.0.0.0/16"
  private_subnet_1 = "10.0.0.0/19"
  private_subnet_2 = "10.0.32.0/19"
  private_subnet_3 = "10.0.128.0/19"
  public_subnet_1  = "10.0.64.0/19"
  public_subnet_2  = "10.0.96.0/19"
  public_subnet_3  = "10.0.160.0/19"
  ##### Logs #####
  enable_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]
}
output "eks" {
  value = module.eks.eks
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

## Application Deployment Example

```
---
apiVersion: v1
kind: Namespace
metadata:
  name: dev
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dev
  namespace: dev
spec:
  selector:
    matchLabels:
      app: dev
  replicas: 2
  template:
    metadata:
      labels:
        app: dev
    spec:
      containers:
      - image: nginx
        name: dev
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: dev
  namespace: dev
spec:
  ports:
  - port: 80
    protocol: TCP
  type: ClusterIP
  selector:
    app: dev
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: dev
  namespace: dev
  annotations:
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip #external dns will create record
    alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:us-east-1:303062045729:certificate/0184b431-097f-409e-9df6-4a2c8526886f
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS":443}]'
    alb.ingress.kubernetes.io/ssl-redirect: '443'
    alb.ingress.kubernetes.io/group.name: dev
spec:
  ingressClassName: alb
  rules:
    - host: dev.yourdomain.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: dev
                port:
                  number: 80
```

Ingress annotations 
```
alb.ingress.kubernetes.io/scheme: internet-facing
alb.ingress.kubernetes.io/target-type: ip #external dns will create record
alb.ingress.kubernetes.io/certificate-arn: <insert your certificate arn >
alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS":443}]'
alb.ingress.kubernetes.io/ssl-redirect: '443'
alb.ingress.kubernetes.io/group.name: dev
```
