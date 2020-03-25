#!/bin/bash
if [ $# -lt 2 ]; then
    echo "Usage: deploy.sh <SSH_USERNAME> <PLAYBOOK> <Optional Args>"
    echo "Optional Args are appended to ansible-playbook"
    exit 1
fi

# Save username and playbook name and remove aguments with shift
SSH_USERNAME=$1
shift
PLAYBOOK=$1
shift

# Install Ansible Roles
ansible-galaxy install -r requirements.yml
# Install Ansible Collectios
ansible-galaxy collection install -r requirements.yml
# Run playbook
ansible-playbook -i ./production ./playbooks/$PLAYBOOK -e "ansible_ssh_user=$SSH_USERNAME" --vault-password-file ~/.vault_pass.txt $@