#!/bin/bash
if [ $# -lt 1 ]; then
    echo "Usage: deploy.sh <SSH_USERNAME> <Optional Args>"
    echo "Optional Args are appended to ansible-playbook"
    exit 1
fi

# Save username and remove first agument with shift
SSH_USERNAME=$1
shift

# Install Ansible Roles
ansible-galaxy install -r requirements.yml
# Install Ansible Collectios
ansible-galaxy collection install -r requirements.yml
# Run playbook
ansible-playbook -i ./production ./playbooks/site.yml -e "ansible_ssh_user=$SSH_USERNAME" --vault-password-file ~/.vault_pass.txt $@