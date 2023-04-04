#apply mesh by peer by default 
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/meshgw.yaml --context $dc1
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/meshgw.yaml --context $ap1
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/meshgw.yaml --context $ap2

#Deploy proxy defaults
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/proxydefaults.yaml --context $dc1
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/proxydefaults.yaml --context $ap1
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/proxydefaults.yaml --context $ap2

# Deploy service-a to tenant-1
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-1/service-a.yaml --context $ap1

#port forward to service-a
kubectl port-forward service-a-66db6c75d-n2hds  9090:9090 --address 0.0.0.0 --context $ap1

# Deploy service-b to tenant-2
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/service-b-v1.yaml --context $ap2
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/service-b-v2.yaml --context $ap2

#Get service-a talking to service-b
    #Export the services cross tenant.
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-1/expap1.yaml --context $ap1
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/expap2.yaml --context $ap2 

#Add intention
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/sevb2seva.yaml --context $ap2 

# Deploy service-b to tenant-2
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/service-c-v1.yaml --context $ap2
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/service-c-v2.yaml --context $ap2

#Add intention
kubectl apply -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/sevc2sevb.yaml --context $ap2 






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


export CONSUL_HTTP_TOKEN=bfe0e4bf-4855-5621-fde2-dc4880025f5f
export CONSUL_HTTP_ADDR=https://a9ccba32d672a4a6a822906e6666e67d-648558321.eu-west-2.elb.amazonaws.com
curl --request PUT --header "X-Consul-Token: $CONSUL_HTTP_TOKEN" --data @docdb.json --insecure $CONSUL_HTTP_ADDR/v1/catalog/register

kubectl create secret generic documentdb-tls -n consul  --from-file=caFile=/Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/default_test/rds-combined-ca-bundle.pem

kubectl create secret generic my-secret -n consul  --from-file=key=/Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/default_test/rds-combined-ca-bundle.pem