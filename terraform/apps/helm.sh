sudo apt install jq -y
eksctl utils associate-iam-oidc-provider --cluster dev --approve

eksctl create iamserviceaccount --name ebs-csi-controller-sa --namespace kube-system --cluster "dev" --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy --approve --role-only --role-name AmazonEKS_EBS_CSI_DriverRole

SERVICE_ACCOUNT_ROLE_ARN=$(aws iam get-role --role-name AmazonEKS_EBS_CSI_DriverRole --output json | jq -r '.Role.Arn')

eksctl create addon --name aws-ebs-csi-driver --cluster "dev" --service-account-role-arn "arn:aws:iam::596296296333:role/AmazonEKS_EBS_CSI_DriverRole" --force

helm upgrade -i kubecost oci://public.ecr.aws/kubecost/cost-analyzer --version="1.104.4" --namespace kubecost --create-namespace -f https://raw.githubusercontent.com/kubecost/cost-analyzer-helm-chart/develop/cost-analyzer/values-eks-cost-monitoring.yaml --set prometheus.configmapReload.prometheus.enabled="false"

kubectl get pods -n kubecost

kubectl port-forward --namespace kubecost deployment/kubecost-cost-analyzer 9090

http://localhost:9090

helm uninstall kubecost  --namespace kubecost

-----

sudo apt install jq -y
eksctl utils associate-iam-oidc-provider --cluster dev --approve

eksctl create iamserviceaccount --name ebs-csi-controller-sa --namespace kube-system --cluster "dev" --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy --approve --role-only --role-name AmazonEKS_EBS_CSI_DriverRole

SERVICE_ACCOUNT_ROLE_ARN=$(aws iam get-role --role-name AmazonEKS_EBS_CSI_DriverRole --output json | jq -r '.Role.Arn')

eksctl create addon --name aws-ebs-csi-driver --cluster "dev" --service-account-role-arn "${SERVICE_ACCOUNT_ROLE_ARN}" --force

helm upgrade -i kubecost oci://public.ecr.aws/kubecost/cost-analyzer --version="1.104.4" --namespace kubecost --create-namespace -f https://raw.githubusercontent.com/sahibgasimov/eks-terraform-stable/main/terraform/apps/values-eks-cost-monitoring.yaml --set prometheus.configmapReload.prometheus.enabled="false"

kubectl get pods -n kubecost

kubectl port-forward --namespace kubecost deployment/kubecost-cost-analyzer 9090
