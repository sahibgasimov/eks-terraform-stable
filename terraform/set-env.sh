#!/bin/bash
set -e
sudo yum install git 
sudo yum install wget 
wget https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip
sudo unzip terraform_0.14.7_linux_amd64.zip
sudo chmod +x terraform_0.14.7_linux_amd64.zip
sudo mv terraform /bin
rm -rf terraform_0.14.7_linux_amd64.zip


# install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl 
sudo mv kubectl /bin/
rm -rf 

# install helm 
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    rm -rf get_helm.sh
    rm -rf 

# install nginx controller
cd nginx-ingress-controller/
helm install nginx-controller ./
