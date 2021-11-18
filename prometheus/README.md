### Setup Steps
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
helm repo update

kubectl create namespace monitoring
helm install my-prometheus --values values.yaml --namespace monitoring prometheus-community/prometheus
```

Prometheus Server is at: http://<Public IP>:31000/

### Reference Links
 - https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus
 - https://github.com/prometheus-community/helm-charts

### To Uninstall
helm uninstall my-prometheus --namespace monitoring