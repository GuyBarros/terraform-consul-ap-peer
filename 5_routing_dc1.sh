kubectl apply -f ./deployments/l7_trafficmanagement/nginx-splitter.yaml --context $dc1

kubectl delete -f ./deployments/l7_trafficmanagement/nginx-splitter.yaml --context $dc1
