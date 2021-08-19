# kubernetes-prometheus
Configuration files for setting up prometheus monitoring on Kubernetes cluster.

You can find the full tutorial from here https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/


# Notes By Gayatri

# Setup Prometheus
kubectl create namespace monitoring
cd promentheus/
kubectl apply -f ./prometheus/
kubectl get deployments,services --namespace=monitoring

# Take down Prometheus
kubectl delete -f ./prometheus/
kubectl delete namespace monitoring
kubectl get deployments,services --namespace=monitoring