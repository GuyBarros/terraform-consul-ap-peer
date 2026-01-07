#Peer DCs
#apply mesh by peer by default 
kubectl apply -f ./deployments/dc1_default_test/meshgw.yaml --context $dc1
kubectl apply -f ./deployments/dc2_default/meshgw.yaml --context $dc2


#Deploy proxy defaults
kubectl apply -f ./deployments/dc1_default_test/proxydefaults.yaml --context $dc1
kubectl apply -f ./deployments/dc2_default/proxydefaults.yaml --context $dc2

#################### Peer dc1 to dc2t ##################
#create an acceptor in DC1
kubectl apply -f  ./deployments/peering/acceptor-on-dc1-for-dc2.yaml --context $dc1
#check if CRD got created
kubectl get peeringacceptors --context $dc1
#create peering token secret from DC1 in DC2 (peering token has the same name as the acceptor created above)
kubectl get secret peering-token-dc2-default --context $dc1 -o yaml | kubectl apply --context $dc2 -f -
#Create dialer from dc2 default to dc1 tenant-2 
kubectl apply -f  ./deployments/peering/dialer-dc2.yaml --context $dc2

#################### Hashicups ##################
#IN DC1 deploy API Gateway -> inginx + frontend + public API
kubectl apply -f  ./deployments/hashicups_full/consul-api-gateway.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/routes.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/nginx.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/frontend.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/public-api.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/crd-frontend-intentions.yaml --context $dc1

kubectl apply -f  ./deployments/hashicups_full/payments.yaml --context $dc2
kubectl apply -f  ./deployments/hashicups_full/products-api.yaml --context $dc2
kubectl apply -f  ./deployments/hashicups_full/postgres.yaml --context $dc2
kubectl apply -f  ./deployments/hashicups_full/crd-products-intentions.yaml --context $dc2

kubectl apply -f  ./deployments/peering/hashicups_exported.yaml --context $dc2

#################### Cleanup ##################

#Delete everything
kubectl delete -f  ./deployments/hashicups_full/ --context $dc1
kubectl delete -f  ./deployments/hashicups_full/ --context $dc2
kubectl delete secret peering-token-dc2-default --context $dc2 
kubectl delete -f  ./deployments/peering/acceptor-on-dc1-for-dc2.yaml --context $dc1
kubectl delete -f  ./deployments/peering/dialer-dc2.yaml --context $dc2
kubectl delete -f ./deployments/dc1_default_test/meshgw.yaml --context $dc1
kubectl delete -f ./deployments/dc2_default/meshgw.yaml --context $dc2
kubectl delete -f ./deployments/dc1_default_test/proxydefaults.yaml --context $dc1
kubectl delete -f ./deployments/dc2_default/proxydefaults.yaml --context $dc2
helm delete consul  --namespace consul --wait --debug --kube-context $dc2
kubectl delete ns consul --context $dc2
helm delete consul  --namespace consul --wait --debug --kube-context $dc1
kubectl delete ns consul --context $dc1


