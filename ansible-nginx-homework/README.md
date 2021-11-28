**Prerequisites**
- have ansible installed on a control host
- have passwordless SSH setup
- edit hosts to point to the target machine

ansible = v2.10.5
target machine = Ubuntu 20.04.2 LTS

**Setup NGINX on a target**
1. edit inventory.yaml with the correct credentials
2. run `ansible-playbook -i inventory.yaml nginx.yaml`


