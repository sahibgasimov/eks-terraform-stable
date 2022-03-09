https://antonputra.com/terraform/how-to-create-eks-cluster-using-terraform/#create-iam-oidc-provider-eks-using-terraform

https://www.youtube.com/watch?v=MZyrxzb7yAU&list=PLiMWaCMwGJXkeBzos8QuUxiYT6j8JYGE5&index=8&ab_channel=AntonPutra

https://www.youtube.com/watch?v=EGdN21F2Jfw&ab_channel=AntonPutra
How to Add IAM User and IAM Role to AWS EKS Cluster?

https://antonputra.com/kubernetes/add-iam-user-and-iam-role-to-eks/
How to Add IAM User and IAM Role to AWS EKS Cluster?¶


https://www.youtube.com/watch?v=MZyrxzb7yAU&t=438s&ab_channel=AntonPutra
How to Create EKS Cluster Using Terraform + IAM Roles for Service Accounts & EKS Cluster Autoscaler


aws eks --region us-east-1 update-kubeconfig --name demo

 kube-metrics 
 
 kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.4.2/components.yaml

 ### check your usedid account and role
aws sts get-caller-identity

watch -n 1 -t kubectl get pods
###  Check logs 
kubectl logs -l app=cluster-autoscaler -n kube-system -f
