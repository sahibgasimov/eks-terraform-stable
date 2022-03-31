# eks-terraform-stable

### This terraform code will create 
1. VPC
2. Internet Gateway 
3. Subnets 2 private 2 public
4. Nat Gateway
5. Routes/Route Associations 
6. AWS EKS Cluster
7. Nodes
8. AWS IAM OpenID
9. IAM Roles and  Policies for cluster
10. IAM Policy Autoscaler 
11. Security Group
12. Bastion Host for EKS Cluster

### To create kubeconfig


aws eks --region us-east-1 update-kubeconfig --name demo

 ### Create kube-metrics 
 
 kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.4.2/components.yaml
