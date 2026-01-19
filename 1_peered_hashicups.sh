#Peer DCs
#apply mesh by peer by default 
kubectl apply -f ./deployments/defaults/meshgw.yaml --context $dc1
kubectl apply -f ./deployments/defaults/meshgw.yaml --context $dc2
#kubectl apply -f ./deployments/defaults/meshgw.yaml --context $ap1

#Deploy proxy defaults
kubectl apply -f ./deployments/defaults/proxydefaults.yaml --context $dc1
kubectl apply -f ./deployments/defaults/proxydefaults.yaml --context $dc2
#kubectl apply -f ./deployments/defaults/proxydefaults.yaml --context $ap1
#################### Peer dc1 to dc2 ##################
#create an acceptor in DC1
kubectl apply -f  ./deployments/peering/acceptor-on-dc1-for-dc2.yaml --context $dc1
#check if CRD got created
kubectl get peeringacceptors --context $dc1
#create peering token secret from DC1 in DC2 (peering token has the same name as the acceptor created above)
kubectl get secret peering-token-backend-default --context $dc1 -o yaml | kubectl apply --context $dc2 -f -
#Create dialer from dc2 default to dc1 tenant-2 
kubectl apply -f  ./deployments/peering/dialer-dc2-dc1.yaml --context $dc2
#################### Peer ap1 to dc2 ##################
#create an acceptor in AP1
kubectl apply -f  ./deployments/peering/acceptor-on-ap1-for-dc2.yaml --context $ap1
#check if CRD got created
kubectl get peeringacceptors --context $ap1
#create peering token secret from AP1 in DC2 (peering token has the same name as the acceptor created above)
kubectl get secret peering-token-ap1-backend-default --context $ap1 -o yaml | kubectl apply --context $dc2 -f -
#Create dialer from dc2 default to ap1 tenant-2 
kubectl apply -f  ./deployments/peering/dialer-dc2-ap1.yaml --context $dc2  

