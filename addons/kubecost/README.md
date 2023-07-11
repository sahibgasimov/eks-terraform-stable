<p align="center">
  <img src="https://github.com/sahibgasimov/eks-terraform-stable/assets/100177153/238b3d24-07ad-41b2-8af6-cedec87f1ba1" width="500">
</p>


Please find detailed guide on my blog page https://medium.com/@sahibgasimov/streamline-your-deployment-kubecost-on-aws-eks-with-terraform-helm-and-alb-ingress-17a75c195b7e

##### Before setting up KubeCost  I'd recommend you to go through my previous article where I comprehensively describe setting up an [AWS EKS cluster with an ALB Ingress Controller and External DNS using Terraform](https://medium.com/@sahibgasimov/terraform-mastery-deploying-eks-cluster-custom-module-with-alb-ingress-controller-and-external-dns-9fe328de9f95). This will give you the necessary foundation to follow along with this guide.


## Terraform EKS with Kubecost Addon

This repository contains Terraform configurations to set up an EKS cluster on AWS and deploy Kubecost on it as an addon. 


## Prerequisites

- Terraform 0.15+
- AWS account with necessary permissions
- kubectl installed
- Helm installed

## Usage

1. Clone this repository to your local machine:
```
git clone https://github.com/sahibgasimov/eks-terraform-stable.git
```

2. Navigate to the `addons/kubecost` directory:

```
cd eks-terraform-stable/addons/kubecost
```

3. Customize your configurations by editing `values.yaml` and `terraform.tfvars` as per your requirements.

4. Initialize Terraform:
   
```
terraform init
```

6. Plan the deployment and verify the changes:

```
terraform plan
```

6. Apply the configuration:

```
terraform apply
```


## Configuration

The configuration options are documented in the `values.yaml` and `terraform.tfvars` files. Customize these as per your requirements. 

This setup is built upon a pre-existing EKS setup with an ALB Ingress Controller. If you haven't set this up already, please refer to [this comprehensive guide](https://medium.com/@sahibgasimov/terraform-mastery-deploying-eks-cluster-custom-module-with-alb-ingress-controller-and-external-dns-9fe328de9f95) on setting up an AWS EKS cluster with an ALB Ingress Controller and External DNS using Terraform.

## Contribution

Feel free to contribute to this project by submitting a pull request. Please make sure your changes are well documented.
