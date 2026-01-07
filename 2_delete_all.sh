

kubectl config get-clusters

#DC2
kubectl delete -f  ./deployments/hashicups_full/ --context $dc2
kubectl delete secret peering-token-dc2-default --context $dc2 
kubectl delete -f  ./deployments/peering/dialer-dc2.yaml --context $dc2
kubectl delete -f ./deployments/dc2_default/meshgw.yaml --context $dc2
kubectl delete -f ./deployments/dc2_default/proxydefaults.yaml --context $dc2
helm delete consul  --namespace consul --wait --debug --kube-context $dc2
kubectl delete ns consul --context $dc2

#AP1
kubectl delete -f  ./deployments/hashicups_full/ --context $ap1
helm delete consul  --namespace consul --wait --debug --kube-context $ap1
kubectl delete ns consul --context $ap1

#DC1
kubectl delete -f  ./deployments/hashicups_full/ --context $dc1
kubectl delete -f  ./deployments/peering/acceptor-on-dc1-for-dc2.yaml --context $dc1
kubectl delete -f ./deployments/dc1_default_test/meshgw.yaml --context $dc1
kubectl delete -f ./deployments/dc1_default_test/proxydefaults.yaml --context $dc1
helm delete consul  --namespace consul --wait --debug --kube-context $dc1
kubectl delete ns consul --context $dc1


kubectl config delete-cluster $dc1
kubectl config delete-cluster $ap1
kubectl config delete-cluster $dc2


#################### Cleanup ##################

#Delete everything
kubectl delete -f  ./deployments/hashicups_full/ --context $dc1
kubectl delete -f  ./deployments/hashicups_full/ --context $dc2
kubectl delete secret peering-token-dc2-default --context $dc2 
kubectl delete -f  ./deployments/peering/acceptor-on-dc1-for-dc2.yaml --context $dc1
kubectl delete -f  ./deployments/peering/dialer-dc2.yaml --context $dc2
kubectl delete -f ./deployments/defaults/meshgw.yaml --context $dc1
kubectl delete -f ./deployments/defaults/meshgw.yaml --context $dc2
kubectl delete -f ./deployments/defaults/proxydefaults.yaml --context $dc1
kubectl delete -f ./deployments/defaults/proxydefaults.yaml --context $dc2
helm delete consul  --namespace consul --wait --debug --kube-context $dc2
kubectl delete ns consul --context $dc2
helm delete consul  --namespace consul --wait --debug --kube-context $dc1
kubectl delete ns consul --context $dc1

