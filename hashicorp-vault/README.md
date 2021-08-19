# Notes
 - This will install the vault in "dev" mode so there is no need to unseal
 - This will expose the vault UI at node port 32000
 - Whenever asked for a password or token use the value "root"
 - Followed these links:
   - https://deeptiman.medium.com/secrets-in-kubernetes-and-hashicorp-vault-d04d83d0400b
   - https://learn.hashicorp.com/tutorials/vault/kubernetes-sidecar
   - https://www.vaultproject.io/docs/platform/k8s/helm/configuration#server
   - https://learn.hashicorp.com/tutorials/vault/kubernetes-raft-deployment-guide?in=vault/kubernetes#install-vault
   - https://discuss.hashicorp.com/t/kubernetes-vault-agent-init-sidecar-error-context-deadline-exceeded/24570/2

### STEP 1
```
kubectl create ns vault
helm install vault hashicorp/vault --values vault-values.yaml --namespace vault
```

### STEP 2
```
kubectl exec -n vault -it vault-0 -- /bin/sh
vault login
vault secrets enable -path=secret kv-v2
vault kv put secret/webapp/config username="demoadmin" password="demopwd123"
vault kv get secret/webapp/config
vault auth enable kubernetes
vault write auth/kubernetes/config \
 issuer="https://kubernetes.default.svc.cluster.local" \
 token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
 kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
 kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
vault policy write webapp - <<EOF
 path "secret/data/webapp/config" {
 capabilities = ["read"]
 }
EOF
vault write auth/kubernetes/role/webapp \
 bound_service_account_names=sa-vault \
 bound_service_account_namespaces=vault \
 policies=webapp \
 ttl=24h
exit
```

### STEP 3
```
kubectl create sa sa-vault -n vault
kubectl apply -f sample-deploy.yaml -n vault
```

### STEP 4
```
kubectl exec -n vault \
$(kubectl get pod -n vault -l app=orgchart -o jsonpath="{.items[0].metadata.name}") \
--container orgchart -- cat /vault/secrets/webapp-config.txt
```