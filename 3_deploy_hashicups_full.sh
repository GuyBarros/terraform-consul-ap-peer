kubectl apply -f  ./deployments/hashicups_full/routes-nginx.yaml --context $dc2
kubectl apply -f  ./deployments/hashicups_full/consul-api-gateway.yaml --context $dc2
kubectl apply -f  ./deployments/hashicups_full/nginx_teal.yaml --context $dc2
kubectl apply -f  ./deployments/hashicups_full/nginx.yaml --context $dc2
kubectl apply -f  ./deployments/hashicups_full/frontend.yaml --context $dc2
kubectl apply -f  ./deployments/hashicups_full/public-api.yaml --context $dc2
kubectl apply -f  ./deployments/hashicups_full/payments.yaml --context $dc2
kubectl apply -f  ./deployments/hashicups_full/products-api.yaml --context $dc2
kubectl apply -f  ./deployments/hashicups_full/product-api-db.yaml --context $dc2
kubectl apply -f  ./deployments/hashicups_full/crd-full-intentions.yaml --context $dc2

kubectl apply -f  ./deployments/hashicups_full/routes-nginx-teal.yaml --context $ap1
kubectl apply -f  ./deployments/hashicups_full/consul-api-gateway.yaml --context $ap1
kubectl apply -f  ./deployments/hashicups_full/nginx_teal.yaml --context $ap1
kubectl apply -f  ./deployments/hashicups_full/nginx.yaml --context $ap1
kubectl apply -f  ./deployments/hashicups_full/frontend.yaml --context $ap1
kubectl apply -f  ./deployments/hashicups_full/public-api.yaml --context $ap1
kubectl apply -f  ./deployments/hashicups_full/payments.yaml --context $ap1
kubectl apply -f  ./deployments/hashicups_full/products-api.yaml --context $ap1
kubectl apply -f  ./deployments/hashicups_full/product-api-db.yaml --context $ap1
kubectl apply -f  ./deployments/hashicups_full/crd-full-intentions.yaml --context $ap1


################## Optional DC1 Deployment ###################

kubectl apply -f  ./deployments/hashicups_full/routes-nginx.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/consul-api-gateway.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/nginx_teal.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/nginx.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/frontend.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/public-api.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/payments.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/products-api.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/product-api-db.yaml --context $dc1
kubectl apply -f  ./deployments/hashicups_full/crd-full-intentions.yaml --context $dc1

kubectl delete -f  ./deployments/hashicups_full/frontend-v2.yaml --context $dc1

kubectl delete -f  ./deployments/hashicups_full/products-api.yaml --context $dc1