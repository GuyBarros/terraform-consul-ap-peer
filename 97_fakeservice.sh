# Services
kubectl apply -f  ./deployments/fake_service/service-a.yaml --context $dc1
kubectl apply -f  ./deployments/fake_service/service-c-v2.yaml --context $dc1
kubectl apply -f  ./deployments/fake_service/service-b-v1.yaml --context $dc1
kubectl apply -f  ./deployments/fake_service/service-b-v2.yaml --context $dc1
kubectl apply -f  ./deployments/fake_service/service-c-v1.yaml --context $dc1
kubectl apply -f  ./deployments/fake_service/service-c-v2.yaml --context $dc1
# Intentions
kubectl apply -f  ./deployments/fake_service/service-intentions.yaml --context $dc1
# Traffic Shaping
kubectl apply -f  ./deployments/fake_service/service-b-splitter.yaml --context $dc1
# API Gateway
kubectl apply -f  ./deployments/fake_service/consul-api-gateway.yaml --context $dc1
# Routes
kubectl apply -f  ./deployments/fake_service/routes-fake-service.yaml --context $dc1

