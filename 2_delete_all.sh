
kubectl delete -f ./deployments/tenant-2/ --context $ap2
kubectl delete -f ./deployments/tenant-1/ --context $ap1
kubectl delete -f ./deployments/dc1_default_test/ --context $dc1



helm delete consul  --namespace consul --wait --debug --kube-context $ap3
kubectl delete ns consul --context $ap3
helm delete consul  --namespace consul --wait --debug --kube-context $dc2
kubectl delete ns consul --context $dc2
helm delete consul  --namespace consul --wait --debug --kube-context $ap2
kubectl delete ns consul --context $ap2
helm delete consul  --namespace consul --wait --debug --kube-context $ap1
kubectl delete ns consul --context $ap1
helm delete consul  --namespace consul --wait --debug --kube-context $dc1
kubectl delete ns consul --context $dc1

kubectl config get-clusters

kubectl config delete-cluster $dc1
kubectl config delete-cluster $ap1
kubectl config delete-cluster $ap2
kubectl config delete-cluster $dc2
kubectl config delete-cluster $ap3  

kubectl config delete-cluster api-cluster-l8n8j-dynamic-redhatworkshops-io:6443
kubectl config delete-cluster cluster-1
kubectl config delete-cluster api-cluster-8jjjn-dynamic-redhatworkshops-io:6443
kubectl config delete-cluster api-cluster-66qgd-dynamic-redhatworkshops-io:6443
kubectl config delete-cluster api-itz-50frhq-infra01-lb-fra02-techzone-ibm-com:6443
kubectl config delete-cluster arn:aws:eks:eu-west-2:958215610051:cluster/guystack1-eks
kubectl config delete-cluster api-cluster-ksqmp-dynamic-redhatworkshops-io:6443