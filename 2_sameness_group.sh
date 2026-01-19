#################### Apply Sameness Groups to DC1, AP1 and DC2 ##################
#kubectl delete -f ./deployments/sameness_group/dc1.yaml --context $dc1
kubectl apply -f ./deployments/sameness_group/ap1.yaml --context $ap1
kubectl apply -f ./deployments/sameness_group/dc2.yaml --context $dc2