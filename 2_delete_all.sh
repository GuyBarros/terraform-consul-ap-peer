kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/meshgw.yaml --context $dc1
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/meshgw.yaml --context $ap1
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/meshgw.yaml --context $ap2
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/proxydefaults.yaml --context $dc1
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/proxydefaults.yaml --context $ap1
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/proxydefaults.yaml --context $ap2
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-1/service-a.yaml --context $ap1
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/service-b-v1.yaml --context $ap2
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/service-b-v2.yaml --context $ap2

#Get service-a talking to service-b
    #Export the services cross tenant.
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-1/expap1.yaml --context $ap1
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/expap2.yaml --context $ap2 

#Add intention
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/sevb2seva.yaml --context $ap2 

# Deploy service-b to tenant-2
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/service-c-v1.yaml --context $ap2
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/service-c-v2.yaml --context $ap2

#Add intention
kubectl delete -f /Users/guybarros/GIT_ROOT/BT_ARCAM/deployments/tenant-2/sevc2sevb.yaml --context $ap2 
