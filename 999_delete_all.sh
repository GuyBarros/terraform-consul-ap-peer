

#AP1
kubectl delete -f  ./deployments/hashicups_full/ --context $ap1
kubectl delete -f  ./deployments/samenessgroup/ --context $ap1
kubectl delete -f  ./deployments/peering/ --context $ap1
kubectl delete -f ./deployments/exported_services/ --context $ap1

helm delete consul  --namespace consul --wait --debug --kube-context $ap1
kubectl delete ns consul --context $ap1

#DC2
kubectl delete -f ./deployments/exported_services/ --context $dc2
kubectl delete -f  ./deployments/hashicups_full/ --context $dc2
kubectl delete secret peering-token-dc2-default --context $dc2
kubectl delete -f ./deployments/l7_trafficmanagement/ --context $dc2 
kubectl delete -f  ./deployments/peering/ --context $dc2
kubectl delete -f  ./deployments/samenessgroup/ --context $dc2
helm delete consul  --namespace consul --wait --debug --kube-context $dc2
kubectl delete ns consul --context $dc2


#DC1
kubectl delete -f ./deployments/exported_services/ --context $dc1
kubectl delete -f  ./deployments/hashicups_full/ --context $dc1
kubectl delete secret peering-token-dc2-default --context $dc1
kubectl delete -f ./deployments/l7_trafficmanagement/ --context $dc1 
kubectl delete -f  ./deployments/peering/ --context $dc1
kubectl delete -f  ./deployments/samenessgroup/ --context $dc1
helm delete consul  --namespace consul --wait --debug --kube-context $dc1
kubectl delete ns consul --context $dc1

#after running terraform destroy
# kubectl config use-cluster minikube
# kubectl config delete-cluster $dc1
# kubectl config delete-cluster $ap1
# kubectl config delete-cluster $dc2
# kubectl config delete-context $dc1
# kubectl config delete-context $ap1
# kubectl config delete-context $dc2

#################### Cleanup ##################
