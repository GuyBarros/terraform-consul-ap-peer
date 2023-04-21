############# Base
#apply mesh by peer by default 
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/dc1_default_test/meshgw.yaml --context $dc1
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/dc2_default/meshgw.yaml --context $dc2
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-1/meshgw.yaml --context $ap1
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/meshgw.yaml --context $ap2


#Deploy proxy defaults
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/dc1_default_test/proxydefaults.yaml --context $dc1
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-1/proxydefaults.yaml --context $ap1
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/proxydefaults.yaml --context $ap2
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/dc2_default/proxydefaults.yaml --context $dc2

#################### Tenant-2 ##################
# Deploy service-c to tenant-2
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/service-c-v1.yaml --context $ap2
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/service-c-v2.yaml --context $ap2

# Deploy service-b to tenant-2
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/service-b-v1.yaml --context $ap2
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/service-b-v2.yaml --context $ap2

#Add intention
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/intentions.yaml --context $ap2 

#Get service-a talking to service-b
 #Export the services cross tenant.

kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/exp_ap2.yaml --context $ap2

#################### Tenant-1 ##################
# Deploy service-a to tenant-1
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-1/service-a.yaml --context $ap1

kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-1/exp_ap1.yaml --context $ap1

# Deploy Ingress Gateway
kubectl apply -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-1/igw.yaml --context $ap1




#################### TGW ##################


######################################     Testing ###############################

export CONSUL_HTTP_TOKEN=49cd16da-9fa2-bc48-2ccd-ccd3b3c2b8eb
export CONSUL_HTTP_ADDR=https://a19ef9389f1954b529a65a657aa90d7e-483918336.eu-west-2.elb.amazonaws.com
curl --request PUT --header "X-Consul-Token: $CONSUL_HTTP_TOKEN" --data @docdb.json --insecure $CONSUL_HTTP_ADDR/v1/catalog/register

curl --request PUT --header "X-Consul-Token: $CONSUL_HTTP_TOKEN" --data @dereg.json --insecure $CONSUL_HTTP_ADDR/v1/catalog/deregister

# cluster1-docdb-cluster.cluster-cwwnbexip9py.eu-west-2.docdb.amazonaws.com

