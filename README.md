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

##Additional tooling

### Deploy and Access the Kubernetes Dashboard

https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

### K8S CRD
The CRDs provide the necessary metadata and schema information to the Kubernetes API server so that it can properly handle Ingress resources.
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```
### Create external dns 
```
1. kubectl apply -f k8s/external-dns.yml  
2. kubectl apply -f k8s/nginx-app-test-extenaldns.yml  #test external dns on nginx app, you need also to create A record for alb and modify in the app before launching
Note: external-dns allow policy was given in nodes.tf file 
```
Reference: https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/aws.md
 ### Create kube-metrics 
 ```
 kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.4.2/components.yaml
```
### Installing kubernetes Metrics Server
https://docs.aws.amazon.com/eks/latest/userguide/metrics-server.html
```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl get deployment metrics-server -n kube-system
```
### Prometheus 
https://docs.aws.amazon.com/eks/latest/userguide/prometheus.html
```
kubectl create namespace prometheus

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm upgrade -i prometheus prometheus-community/prometheus \
    --namespace prometheus \
    --set alertmanager.persistentVolume.storageClass="gp2",server.persistentVolume.storageClass="gp2"
    
kubectl get pods -n prometheus
```
