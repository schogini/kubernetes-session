# Kubernetes Session Files
These YAML files are supplements for the Kubernetes Sessions conducted by Schogini Systems.
To know more about this session and various other sessions conducted by Schogini check out http://schogini.com

# Common Kubernetes Commands
```
kubectl create namespace <name>

kubectl get <object type>
kubectl get <object type>,<object type>,<object type>....
kubectl get all
kubectl get <object type> --show-labels
kubectl get <object type> -l <label key>=<label value>
kubectl get <object type> -o wide
kubectl get <object type>/<object name -o yaml

kubectl describe <object type>/<object name>

kubectl delete <object type>/<object name>
kubectl delete -f <path to spec file>
kubectl delete <object type> --all
kubectl delete <object type>,<object type> --all

kubectl apply -f <path to a spec file>
kubectl apply -f <path to a folder containing spec files>
kubectl apply -f <path to a spec file> -f <path to a spec file> ....
kubectl apply -f <url to a spec file>
kubectl apply -f <filename> -n <namespace>

kubectl scale --replicas=<number> deploy/<name>

kubectl rollout history deploy/<name>
kubectl rollout history deploy/<name> --revision=<revision no>
kubectl rollout undo deploy/<name> --to-revisio=<revision no>

kubectl set image deploy/<name> <container name>=<new image name>
kubectl set image deploy/<name> <container name>=<new image name> --record

kubectl exec pod/<name> [-ti] -- <command>
kubectl exec pod/<name> [-ti] -c <container name> <command>

kubectl create secret <type> <name> <content>
<type>
	generic
	docker-registry
	tls
<content>
	--from-file=<file path>
	--from-file=<key>=<file path>
	--from-env-file (env data)
	--from-literal=<key>=<value>

kubectl apply -f <filename> --dry-run=client --validate

kubeadm token create --print-join-command

kubectl label nodes <node name> <key>=<value>
kubectl label nodes <node name> <key>-

kubectl taint nodes <node name> <key>=<value>:<taint-effect>
kubectl taint nodes <node name> <key>=<value>:<taint-effect>-
	NoSchedule
	PreferNoSchedule
	NoExecute
```

Update Strategy:
+ RollingUpdate
+ Recreate

Abbreviation:
 + pods = po
 + deployments = deploy
 + services = svc
 + replicasets = rs
 + configmap = cm
 + persistentvolume = pv
 + persistentvolumeclaim = pvc


Cluster Setup with Kubeadm - Master Node
```
kubeadm init --pod-network-cidr=10.244.0.0/16
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=<VERSION>"
```
Allow the master to be used as the node
```
kubectl taint nodes <master node> node-role.kubernetes.io/master:NoSchedule-
```
Default cluster domain name: cluster.local
```
<service name>.<namespace>.svc.<cluster domain name>:<service port>
```
