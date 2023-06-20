########
#!/bin/sh


### All files are in a Github repo:
# https://github.com/hugomcruz/files 


### MOCK INVENTORY
kubectl --insecure-skip-tls-verify delete -f https://raw.githubusercontent.com/hugomcruz/files/main/k8s-mock-inventory.yaml

### MOCK LOGBOOK
kubectl --insecure-skip-tls-verify delete -f https://raw.githubusercontent.com/hugomcruz/files/main/k8s-mock-logbook.yaml


### MOCK RESOLVE
kubectl --insecure-skip-tls-verify delete -f https://raw.githubusercontent.com/hugomcruz/files/main/k8s-mock-resolve.yaml

