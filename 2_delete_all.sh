
kubectl delete -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-1/ --context $ap1
kubectl delete -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/tenant-2/ --context $ap2
kubectl delete -f /Users/guybarros/GIT_ROOT/terraform-consul-ap-peer/deployments/dc1_default_test/ --context $dc1



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