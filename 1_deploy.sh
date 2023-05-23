############# Base
#apply mesh by peer by default 
kubectl apply -f ./deployments/dc1_default_test/meshgw.yaml --context $dc1
kubectl apply -f ./deployments/dc2_default/meshgw.yaml --context $dc2


#Deploy proxy defaults
kubectl apply -f ./deployments/dc1_default_test/proxydefaults.yaml --context $dc1
kubectl apply -f ./deployments/tenant-1/proxydefaults.yaml --context $ap1
kubectl apply -f ./deployments/tenant-2/proxydefaults.yaml --context $ap2
kubectl apply -f ./deployments/dc2_default/proxydefaults.yaml --context $dc2

#################### Tenant-2 ##################
# Deploy service-c to tenant-2
kubectl apply -f ./deployments/tenant-2/service-c-v1.yaml --context $ap2
kubectl apply -f ./deployments/tenant-2/service-c-v2.yaml --context $ap2

# Deploy service-b to tenant-2
kubectl apply -f ./deployments/tenant-2/service-b-v1.yaml --context $ap2
kubectl apply -f ./deployments/tenant-2/service-b-v2.yaml --context $ap2
# Deploy service-a to tenant-2
kubectl apply -f ./deployments/tenant-2/service-a.yaml --context $ap2

#Add intention
kubectl apply -f ./deployments/tenant-2/intentions.yaml --context $ap2 

#Get service-a talking to service-b
 #Export the services cross tenant.

kubectl apply -f ./deployments/tenant-2/exp_ap2.yaml --context $ap2

#################### Tenant-1 ##################
# Deploy service-a to tenant-1
kubectl apply -f ./deployments/tenant-1/service-a.yaml --context $ap1

kubectl apply -f ./deployments/tenant-1/exp_ap1.yaml --context $ap1

# Deploy Ingress Gateway
kubectl apply -f ./deployments/tenant-1/igw.yaml --context $ap1


kubectl get svc -n consul --context $ap1

######################################## Peering #########################################
#################### Services -Default DC2 ##################
kubectl apply -f ./deployments/dc2_default/service-a.yaml --context $dc2
kubectl apply -f ./deployments/dc2_default/service-b-v1.yaml --context $dc2
kubectl apply -f ./deployments/dc2_default/service-c-v1.yaml --context $dc2

kubectl apply -f ./deployments/dc2_default/igw.yaml --context $dc2

kubectl apply -f ./deployments/dc2_default/intentions.yaml --context $dc2
#################### Peer dc1-tentant-2 to dc2-default ##################
#create an acceptor in tenant-2
kubectl apply -f  ./deployments/peering/acceptor-on-ap2-for-dc2.yaml --context $ap2
#check if CRD got created
kubectl get peeringacceptors --context $ap2
#create peering token secret from DC1 in DC2 (peering token has the same name as the acceptor created above)
kubectl get secret peering-token-dc2-default --context $ap2 -o yaml | kubectl apply --context $dc2 -f -
#Create dialer from dc2 default to dc1 tenant-2 
kubectl apply -f  ./deployments/peering/dialer-dc2.yaml --context $dc2
#export services from dc2 to dc1 
kubectl apply -f  ./deployments/peering/exported.yaml --context $dc2




#################### Traffic Management ##################

# kubectl apply -f ./deployments/tenant-2/service-b-router-header.yaml --context $ap2
# kubectl apply -f ./deployments/tenant-2/service-b-router-query.yaml --context $ap2

# kubectl apply -f ./deployments/tenant-1/service-a-router-header.yaml --context $ap1
#################### Router ##################
kubectl apply -f ./deployments/tenant-1/service-a-router-query.yaml --context $ap1
#################### Splitter ##################
kubectl apply -f ./deployments/tenant-2/service-b-splitter.yaml --context $ap2

#################### Resolver ##################
kubectl apply -f ./deployments/tenant-1/service-a-resolver.yaml --context $ap1
kubectl apply -f ./deployments/tenant-1/service-a-resolver.yaml --context $ap2
kubectl apply -f ./deployments/tenant-1/service-b-resolver.yaml --context $ap2
kubectl apply -f ./deployments/tenant-1/service-c-resolver.yaml --context $ap2

######################################     Testing ###############################

export CONSUL_HTTP_TOKEN=1ca900b5-cff9-7d32-3e4e-79253b3ed643
export CONSUL_HTTP_ADDR=https://a5b31bb80f95b41cc9d17433b34c24a0-699327247.eu-west-2.elb.amazonaws.com
curl --request PUT --header "X-Consul-Token: $CONSUL_HTTP_TOKEN" --data @docdb.json --insecure $CONSUL_HTTP_ADDR/v1/catalog/register

curl --request PUT --header "X-Consul-Token: $CONSUL_HTTP_TOKEN" --data @dereg.json --insecure $CONSUL_HTTP_ADDR/v1/catalog/deregister

# cluster1-docdb-cluster.cluster-cwwnbexip9py.eu-west-2.docdb.amazonaws.com

