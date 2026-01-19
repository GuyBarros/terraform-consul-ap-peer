kubectl apply -f ./deployments/l7_trafficmanagement/virtual_nginx.yaml --context $dc1
kubectl apply -f ./deployments/l7_trafficmanagement/virtual_nginx_teal.yaml --context $dc1
kubectl apply -f ./deployments/l7_trafficmanagement/consul-api-gateway.yaml --context $dc1
# kubectl apply -f ./deployments/l7_trafficmanagement/routes-virtual-nginx.yaml --context $dc1
kubectl apply -f ./deployments/l7_trafficmanagement/routes-nginx-copy.yaml --context $dc1



kubectl delete -f ./deployments/l7_trafficmanagement/virtual_nginx.yaml --context $dc1
kubectl delete -f ./deployments/l7_trafficmanagement/routes-nginx-copy.yaml --context $dc1


kubectl delete -f ./deployments/l7_trafficmanagement/virtual_nginx_teal.yaml --context $dc1