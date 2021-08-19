## Setup Dashboard
```
kubectl create ns kubernetes-dashboard
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo update
helm install kubernetes-dashboard -f values.yaml kubernetes-dashboard/kubernetes-dashboard -n kubernetes-dashboard
```

## Setup Metrics Server
```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl edit deployment/metrics-server --namespace kube-system
```
Add this to the args section
```
- --kubelet-insecure-tls=true
```
Confirm metrics server is up
```
kubectl top node
```

## Setup Sample User for Dashboard & Get the token
```
kubectl apply -f sample-user.yaml
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
```

## Reference Links
- https://github.com/kubernetes/dashboard
- https://artifacthub.io/packages/helm/k8s-dashboard/kubernetes-dashboard
- https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md
- https://github.com/kubernetes-sigs/metrics-server