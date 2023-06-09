
# Update kubeconfig after deploying each EKS cluster
#DC1
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name_cluster1)
#AP1
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name_cluster2)
#AP2
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name_cluster3)
#DC2
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name_cluster4)
#AP3
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name_cluster5)


#Kubectl get clusters
kubectl config get-clusters

# update these variables every deploy
export dc1=arn:aws:eks:eu-west-2:958215610051:cluster/cluster1-eks-GVXQiaCh
export ap1=arn:aws:eks:eu-west-2:958215610051:cluster/cluster2-eks-2b2KUDB2
export ap2=arn:aws:eks:eu-west-2:958215610051:cluster/cluster3-eks-YZTNKrQs
export dc2=arn:aws:eks:eu-west-2:958215610051:cluster/cluster4-eks-vwSLaBw6
export ap3=arn:aws:eks:eu-west-2:958215610051:cluster/cluster5-eks-XeBKytxF

# DC1
kubectl config use-context $dc1
# Create the k8s namespace
kubectl create ns consul --context $dc1
#Create the consul ent license k8s secret
kubectl create secret generic consul-ent-license --namespace consul --from-file=key=/Users/guybarros/Hashicorp/consul.hclic --context $dc1
#create the PEM file secret for the terminating gateway
#kubectl create secret generic documentdb-tls -n consul  --from-file=caFile=./deployments/dc1_default_test/rds-combined-ca-bundle.pem --context $dc1

# Install Consul
helm install consul hashicorp/consul --namespace consul --values ./helm_values/dc1.yaml --wait --debug  --kube-context $dc1
#helm upgrade consul hashicorp/consul --namespace consul --values ./helm_values/dc1.yaml --wait --debug  --kube-context $dc1

#Get the UI load balancer
kubectl get svc -n consul --context $dc1

# Get the bootstrap token, may need to change the name
kubectl get secret -n consul consul-bootstrap-acl-token -o jsonpath="{.data.token}" --context $dc1 | base64 --decode

#apply mesh by peer by default 
kubectl apply -f ./deployments/dc1_default_test/ --context $dc1
kubectl apply -f ./deployments/dc1_default_test/todo.yaml --context $dc1

#AP1
kubectl config use-context $ap1
# Create the k8s namespace
kubectl create ns consul --context $ap1
#Create the consul ent license k8s secret
kubectl create secret generic consul-ent-license --namespace consul --from-file=key=/Users/guybarros/Hashicorp/consul.hclic --context $ap1

#Get the info from DC1 and apply it to AP1
kubectl get secret --namespace consul consul-ca-cert -o yaml --context $dc1 | kubectl --context $ap1 apply --namespace consul -f -
kubectl get secret --namespace consul consul-ca-key -o yaml --context $dc1 | kubectl --context $ap1  apply --namespace consul -f -
kubectl get secret --namespace consul consul-partitions-acl-token -o yaml --context $dc1 | kubectl --context $ap1  apply --namespace consul -f -
kubectl get svc consul-expose-servers -n consul  --context $dc1
kubectl cluster-info --context $ap1
# update the helm files with the consul exporse servers and k8s control plane
kubectl config use-context $ap1

# Install Consul
helm install consul hashicorp/consul --namespace consul --values ./helm_values/ap1.yaml --wait --debug --kube-context $ap1
#helm upgrade consul hashicorp/consul --namespace consul --values ./helm_values/ap1.yaml --wait --debug --kube-context $ap1


#AP2
kubectl config use-context $ap2
# Create the k8s namespace
kubectl create ns consul --context $ap2
#Create the consul ent license k8s secret
kubectl create secret generic consul-ent-license --namespace consul --from-file=key=/Users/guybarros/Hashicorp/consul.hclic --context $ap2

#Get the info from DC1 and apply it to AP2
kubectl get secret --namespace consul consul-ca-cert -o yaml --context $dc1 | kubectl --context $ap2 apply --namespace consul -f -
kubectl get secret --namespace consul consul-ca-key -o yaml --context $dc1 | kubectl --context $ap2  apply --namespace consul -f -
kubectl get secret --namespace consul consul-partitions-acl-token -o yaml --context $dc1 | kubectl --context $ap2  apply --namespace consul -f -
kubectl get svc consul-expose-servers -n consul  --context $dc1
kubectl cluster-info --context $ap2
# update the helm files with the consul exporse servers and k8s control plane
kubectl config use-context $ap2

# Install Consul
# Install Consul
helm install consul hashicorp/consul --namespace consul --values ./helm_values/ap2.yaml --wait --debug --kube-context $ap2
#helm upgrade consul hashicorp/consul --namespace consul --values ./helm_values/ap2.yaml --wait --debug --kube-context $ap2


#DC2
kubectl config use-context $dc2
# Create the k8s namespace
kubectl create ns consul --context $dc2
#Create the consul ent license k8s secret
kubectl create secret generic consul-ent-license --namespace consul --from-file=key=/Users/guybarros/Hashicorp/consul.hclic --context $dc2

# Install Consul
helm install consul hashicorp/consul --namespace consul --values ./helm_values/dc2.yaml --wait --debug --kube-context $dc2
#helm upgrade consul hashicorp/consul --namespace consul --values ./helm_values/dc2.yaml --wait --debug --kube-context $dc2

#Get the UI load balancer
kubectl get svc -n consul --context $dc2

# Get the bootstrap token, may need to change the name
kubectl get secret -n consul consul-bootstrap-acl-token -o jsonpath="{.data.token}" --context $dc2 | base64 --decode


#AP3
kubectl config use-context $ap3
# Create the k8s namespace
kubectl create ns consul --context $ap3
#Create the consul ent license k8s secret
kubectl create secret generic consul-ent-license --namespace consul --from-file=key=/Users/guybarros/Hashicorp/consul.hclic --context $ap3

#Get the info from DC2 and apply it to AP3
kubectl get secret --namespace consul consul-ca-cert -o yaml --context $dc2 | kubectl --context $ap3 apply --namespace consul -f -
kubectl get secret --namespace consul consul-ca-key -o yaml --context $dc2 | kubectl --context $ap3  apply --namespace consul -f -
kubectl get secret --namespace consul consul-partitions-acl-token -o yaml --context $dc2 | kubectl --context $ap3  apply --namespace consul -f -
kubectl get svc consul-expose-servers -n consul  --context $dc2
kubectl cluster-info --context $ap3
# update the helm files with the consul exporse servers and k8s control plane
kubectl config use-context $ap3

# Install Consul
helm install consul hashicorp/consul --namespace consul --values ./helm_values/ap3.yaml --wait --debug --kube-context $ap3

