#!/bin/bash

# Default variables
SSH_USERNAME=$USER
PLAYBOOK="site.yml"
VAULT_PASS_LOCATION="--vault-password-file $HOME/.vault_pass.txt"

usage() {
    echo "Usage: ${0} [-upaks]"
    echo "-u ssh username. Default is $USER"
    echo "-p Playbook name. Default is $PLAYBOOK"
    echo "-a Optional args appended to ansible-playbook command"
    echo "-k Prompt for password instead of looking in $VAULT_PASS_LOCATION"
    echo "-s Location of Vault secrets folder"
    exit 1
}

# Set variables
while getopts u:p:a:ks: OPT
do
    case "$OPT" in
    u) SSH_USERNAME="$OPTARG";;
    p) PLAYBOOK="$OPTARG";;
    a) ANSIBLE_ARGS="$OPTARG";;
    k) VAULT_PASS_LOCATION="";;
    s) VAULT_SECRETS_FOLDER="--extra-vars \"VAULT_FOLDER=$OPTARG\"";;
    *) usage
    esac
done
shift $(( $OPTIND-1 ))

# Check for unhandled argument
if [[ "${#}" -ne 0 ]]
then
    usage
fi

# Install Ansible Roles
ansible-galaxy install -r requirements.yml
# Install Ansible Collectios
ansible-galaxy collection install -r requirements.yml
# Run playbook
echo ansible-playbook ./playbooks/$PLAYBOOK -e \"ansible_ssh_user=$SSH_USERNAME\" $VAULT_SECRETS_FOLDER $VAULT_PASS_LOCATION $ANSIBLE_ARGS
eval ansible-playbook ./playbooks/$PLAYBOOK -e \"ansible_ssh_user=$SSH_USERNAME\" $VAULT_SECRETS_FOLDER $VAULT_PASS_LOCATION $ANSIBLE_ARGS