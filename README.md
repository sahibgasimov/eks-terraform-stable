## eks-terraform-stable

### This terraform code will create AWS EKS Cluster
1. VPC
2. Internet Gateway 
3. Subnets 3 private 3 public
4. Nat Gateway
5. Routes/Route Associations 
6. AWS EKS Cluster
7. Nodes
8. AWS IAM OpenID
9. IAM Roles and  Policies for cluster
10. IAM Policy Autoscaler 
11. Security Group
12. Bastion Host for EKS Cluster
13. EBS CSI Driver 
14. ACM Cert for ALB/external DNS

### To create kubeconfig

aws eks --region us-east-1 update-kubeconfig --name demo

### Create external dns

1. kubectl apply -f k8s/external-dns.yml  
2. kubectl apply -f k8s/nginx-app-test-extenaldns.yml  #test external dns on nginx app, you need also to create A record for alb and modify in the app before launching

 ### Create kube-metrics 
 
 kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.4.2/components.yaml
