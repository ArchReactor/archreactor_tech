# Archreactor
Server setup and configuration for Archreactor (archreactor.org)

# Requirements
Linux System
Ansible
SSH credentials for Archreactor servers
Ansible Vault password

# Deploying
```deploy.sh <SSH USERNAME>```
Deploy script runs the Ansible playbook anisble/playbooks/site.yml using ansible/production as a list of hosts. 