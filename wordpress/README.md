
## Note
Before your execute the YAML files create the secret for the DB password
```
kubectl create secret generic mysql-pass --from-literal=password=<YOUR_PASSWORD>
```