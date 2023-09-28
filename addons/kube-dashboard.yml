#!/bin/bash

# Apply cert-manager CRDs
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.5.3/cert-manager.crds.yaml

# Apply Kubernetes dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml

# Apply Namespace, ServiceAccount, and ClusterRoleBinding configurations
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: kubernetes-dashboard
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

# Create token for admin-user
echo "Here is your kube-dashboard token"
kubectl create token admin-user -n kubernetes-dashboard
echo
# Retrieve and display the token for the admin-user
echo "Here is your describe secret details:"
echo 
kubectl -n kubernetes-dashboard get  secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
echo 

# Forward port for kubernetes-dashboard pod in the background and suppress the output
kubectl port-forward $(kubectl get pods -n kubernetes-dashboard -l k8s-app=kubernetes-dashboard -o jsonpath="{.items[0].metadata.name}") -n kubernetes-dashboard 8443:8443 > /dev/null 2>&1 &

echo
echo "http://localhost:8443/"
echo
