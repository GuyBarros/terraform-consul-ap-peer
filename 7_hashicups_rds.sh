#if needed, deploy Hashicups
#kubectl apply -f  ./deployments/hashicups_full/routes-nginx.yaml --context $dc1
#kubectl apply -f  ./deployments/hashicups_full/consul-api-gateway.yaml --context $dc1
#kubectl apply -f  ./deployments/hashicups_full/nginx_teal.yaml --context $dc1
#kubectl apply -f  ./deployments/hashicups_full/nginx.yaml --context $dc1
#kubectl apply -f  ./deployments/hashicups_full/frontend.yaml --context $dc1
#kubectl apply -f  ./deployments/hashicups_full/public-api.yaml --context $dc1
#kubectl apply -f  ./deployments/hashicups_full/payments.yaml --context $dc1
#kubectl apply -f  ./deployments/hashicups_full/crd-full-intentions.yaml --context $dc1

kubectl apply -f  ./deployments/hashicups_rds/product-api.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_rds/rds.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_rds/terminating-gateway.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_rds/service-intentions.yaml --context $dc1