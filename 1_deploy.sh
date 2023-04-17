#apply mesh by peer by default 
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/dc1_default_test/meshgw.yaml --context $dc1
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/dc2_default/meshgw.yaml --context $dc2

#Deploy proxy defaults
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/dc1_default_test/proxydefaults.yaml --context $dc1
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-1/proxydefaults.yaml --context $ap1
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/proxydefaults.yaml --context $ap2
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/dc2_default/proxydefaults.yaml --context $dc2

# Deploy service-c to tenant-2
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/service-c-v1.yaml --context $ap2
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/service-c-v2.yaml --context $ap2

#Add intention
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/sevc2v1sevb.yaml --context $ap2 
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/sevc2v2sevb.yaml --context $ap2 

# Deploy service-b to tenant-2
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/service-b-v1.yaml --context $ap2
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/service-b-v2.yaml --context $ap2

#Get service-a talking to service-b
 #Export the services cross tenant.

kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/exp_ap2.yaml --context $ap2

#Add intention
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/sevb2v1seva.yaml --context $ap2 
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/sevb2v2seva.yaml --context $ap2 

# Deploy service-a to tenant-1
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-1/service-a.yaml --context $ap1

kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-1/exp_ap1.yaml --context $ap1

# Deploy Ingress Gateway
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-1/igw.yaml --context $ap1


######################
#testing without transpernt proxy DELETE ME AFTER

kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/dc1_default_test/igw.yaml --context $dc1

#####################




#add external service
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/extvault.yaml --context $ap1

#add terminating gateway
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/terminatingGateway.yaml --context $ap1

kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/example.yaml --context $ap1

kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/static-client.yaml --context $ap1

kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/igw.yaml --context $ap1


////////
apply mesh by peer by default 
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/meshgw.yaml --context $ap2

# Deploy service-a to tenant-1
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/service-a2.yaml --context $ap1
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/service-a2.yaml --context $ap1
# Deploy service-c to tenant-2
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/service-c.yaml --context $ap2

#Export the services cross tenant.
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/expap1.yaml --context $ap1
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/expap2.yaml --context $ap2 

#Add intention
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/ap2-intention.yaml --context $ap2 

#test service default
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/ap1default.yaml --context $ap1
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/ap1default.yaml --context $ap2

kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/proxydefaults.yaml --context $ap1
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/proxydefaults.yaml --context $ap2


#Ingress Gateway to Service-A
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-1/igw.yaml --context $ap1 


export CONSUL_HTTP_TOKEN=4233f441-aef5-0df5-4521-ae925408b81c
export CONSUL_HTTP_ADDR=https://acca376c9f5214f51ae9e01168661916-2058900592.eu-west-2.elb.amazonaws.com
curl --request PUT --header "X-Consul-Token: $CONSUL_HTTP_TOKEN" --data @docdb.json --insecure $CONSUL_HTTP_ADDR/v1/catalog/register

kubectl create secret generic documentdb-tls -n consul  --from-file=caFile=/Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/default_test/rds-combined-ca-bundle.pem

kubectl create secret generic my-secret -n consul  --from-file=key=/Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/default_test/rds-combined-ca-bundle.pem