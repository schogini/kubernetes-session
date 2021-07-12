#!/bin/sh

curl -L https://istio.io/downloadIstio | sh -
cd istio-1.10.0
export PATH=$PWD/bin:$PATH
cd ../
istioctl install --set profile=demo -y
kubectl create namespace myistio
kubectl label namespace myistio istio-injection=enabled
kubectl apply -f ./ -n myistio
kubectl get svc istio-ingressgateway -n istio-system

# Setup Kiali and all the recommended addons that come in the samples folder of istio
# Remember, you need to apply it twice since, some objects may take time to create
# Note: Earlier, (just to keep things simple) I had installed only prometheus & kiali like this:
# kubectl apply -f istio-1.8.0/samples/addons/prometheus.yaml -n istio-system
# kubectl apply -f istio-1.8.0/samples/addons/kiali.yaml -n istio-system
# sleep 5
# kubectl apply -f istio-1.8.0/samples/addons/kiali.yaml -n istio-system

kubectl apply -f istio-1.10.0/samples/addons/ -n istio-system
sleep 5
kubectl apply -f istio-1.10.0/samples/addons/ -n istio-system

kubectl get service kiali -n istio-system -o yaml > kiali.yaml && sed -i "s/type: ClusterIP/type: NodePort/g" kiali.yaml && kubectl apply -f kiali.yaml
rm kiali.yaml
kubectl get service kiali -n istio-system
