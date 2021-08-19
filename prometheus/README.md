### Setup Steps
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
helm repo update

helm install my-prometheus --values values.yaml --namespace monitoring prometheus-community/prometheus
```

Prometheus Server is at: http://<Public IP>:31000/
