#!/bin/bash
set -e
sudo yum install git 
sudo yum install wget 
wget https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip
sudo unzip terraform_0.14.7_linux_amd64.zip
sudo chmod +x terraform_0.14.7_linux_amd64.zip
sudo mv terraform /bin