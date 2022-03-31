#!/bin/bash


while true
do
    echo "${y}1${rs}. Install   terraform, helm, kubectl and ingress-controller prerequisites "
    echo "${y}2${rs}. uninstall ingress-controller"
    echo "${y}3${rs}. Quit"
    read -p "Enter your choice: " choice
    if [ $choice -eq 1 ]
        # If inventory folder doesn't exist create it
    then
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

# install helm 
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    rm -rf get_helm.sh

# install nginx controller
cd nginx-ingress-controller/
helm install ingress-controller ./


    elif [ $choice -eq 2 ]
    then
helm uninstall ingress-controller

    elif [ $choice -eq 3 ]
    then 
         break
     else
         continue
    fi
done
