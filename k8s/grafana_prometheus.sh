#!/bin/bash
# Deploy Prometheus and Grafana
exit_on_error() {
    exit_code=$1
    last_command=${@:2}
    if [ $exit_code -ne 0 ]; then
        >&2 echo "\"${last_command}\" command failed with exit code ${exit_code}."
        exit $exit_code
    fi
}
rs=`tput sgr0`    # reset
g=`tput setaf 2`  # green
y=`tput setaf 3`  # yellow
r=`tput setaf 1`  # red
b=`tput bold`     # bold
u=`tput smul`     # underline
nu=`tput rmul`    # no-underline

echo ${g}"
    What this script does?:
Installs Prometheus and grafana ( access thru LoadBalancer)
"${rs}

while true
do
    echo "${y}1${rs}. Install Prometheus and Grafana "
    echo "${y}2${rs}. Destroy Prometheus and Grafana"
    echo "${y}3${rs}. Quit"
    read -p "Enter your choice: " choice

if [ $choice -eq 1 ]
then
        if [[ $? = 0 ]]; then
            # add prometheus Helm repo
            helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
            helm repo update
            # add grafana Helm repo
            helm repo add grafana https://grafana.github.io/helm-charts
            helm repo update
            echo ${y}"Added Prometheus and Grafana repo"${rs}
        else
            echo ${r}"repo add failed"${rs} 1>&2
        fi

    if [ $? = 0 ]; then

kubectl create namespace prometheus

helm upgrade --install prometheus prometheus-community/prometheus \
    --namespace prometheus \
    --set alertmanager.persistentVolume.storageClass="gp2" \
    --set server.persistentVolume.storageClass="gp2"
kubectl get all -n prometheus
else 
echo ${r}"failed to create namespace or install prometheus"${rs}
fi

if [ $? = 0 ]; then
sudo mkdir ${HOME}/environment/grafana
else
echo ${r}"were unable to create grafana home folder"${rs}
fi

if [ $? = 0 ]; then


sudo mkdir -p ${HOME}/environment/grafana
sudo touch ${HOME}/environment/grafana/grafana.yaml
sudo chmod 777 ${HOME}/environment/grafana/grafana.yaml

sudo cat << EoF > ${HOME}/environment/grafana/grafana.yaml
datasources:
  datasources.yaml:
    apiVersion: 1
    datasources:
    - name: Prometheus
      type: prometheus
      url: http://prometheus-server.prometheus.svc.cluster.local
      access: proxy
      isDefault: true
EoF

kubectl create namespace grafana

helm upgrade --install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --set adminPassword='EKS!sAWSome' \
    --values ${HOME}/environment/grafana/grafana.yaml \
    --set service.type=LoadBalancer
    sleep 5
kubectl get all -n grafana

export ELB=$(kubectl get svc -n grafana grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "Use LoabBalancer path for grafana"
echo "http://$ELB"

echo -e "this is your password: "
kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

else 
    echo "failed to install grafana"
fi

sleep 7
echo "wait.................................................."
echo ${g}"kubectl get all -n grafana"
kubectl get all -n grafana
echo ${g}"kubectl get all -n prometheus"
kubectl get all -n prometheus


export password=$(kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo)
export ELB=$(kubectl get svc -n grafana grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')



echo -e ${y} "Your grafana link:  http://$ELB "
echo -e "Your grafana username:  admin"
echo -e "Your grafana password:  $password"${rs}

echo -n "

${b}##################################Cluster Grafana Monitoring Dashboard#########################${rs}

${u}For creating a dashboard to monitor the cluster:${rs}

Click '+' button on left panel and select ‘Import’.
Enter 3119 dashboard id under Grafana.com Dashboard.
Click ‘Load’.
Select ‘Prometheus’ as the endpoint under prometheus data sources drop down.
Click ‘Import’. 

${b}##################################Pods Monitoring Dashboard###################################${rs}

${u}For creating a dashboard to monitor all the pods:${rs}

Click '+' button on left panel and select ‘Import’.
Enter 6417 dashboard id under Grafana.com Dashboard.
Click ‘Load’.
Enter Kubernetes Pods Monitoring as the Dashboard name.
Click change to set the Unique identifier (uid).
Select ‘Prometheus’ as the endpoint under prometheus data sources drop down.s
Click ‘Import’."

echo ""

# UNINSTALL GRAFANA AND PROMETHEUS
elif [ $choice -eq 2 ]
then
helm repo remove prometheus-community
helm uninstall prometheus --namespace prometheus
kubectl delete ns prometheus

helm repo remove grafana
helm uninstall grafana --namespace grafana
kubectl delete ns grafana

if [ $? = 0 ]; then
sudo rm -rf ${HOME}/environment/grafana
echo ${g}"removed grafana home folder"${rs}
else 
    echo "failed to remove grafana folder"
fi

elif [ $choice -eq 3 ]
then
 break

fi
done
