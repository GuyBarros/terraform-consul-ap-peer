kubectl apply -f ./deployments/exported_services/sameness_hashicups.yaml --context $dc2
kubectl apply -f ./deployments/exported_services/sameness_hashicups_ap1.yaml --context $ap1
kubectl apply -f ./deployments/exported_services/hashicups_exported_dc2.yaml --context $dc2
#kubectl apply -f ./deployments/exported_services/hashicups_exported_ap1.yaml --context $ap1