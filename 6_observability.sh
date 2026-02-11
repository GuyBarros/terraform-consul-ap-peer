
export GRAFANA_PERFORMANCE_DASHBOARD=http://$(kubectl get svc/grafana --namespace observability -o json --context $dc1| jq -r '.status.loadBalancer.ingress[0].hostname')/d/data-plane-performance/ && echo $GRAFANA_PERFORMANCE_DASHBOARD


kubectl apply -f ./deployments/observability/traffic.yaml --context $dc1

kubectl delete -f ./deployments/observability/traffic.yaml --context $dc1