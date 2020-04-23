#!/bin/bash

usage() {
    echo "Usage: ${0} [-upa]"
    echo "-u ssh username. Default is $USER"
    echo "-p Playbook name. Default is site.yml"
    echo "-a Optional args appended to ansible-playbook command"
    exit 1
}

# Set variables
SSH_USERNAME=$USER
PLAYBOOK="site.yml"
while getopts u:p:a: OPT
do
    case "$OPT" in
    u) SSH_USERNAME="$OPTARG";;
    p) PLAYBOOK="$OPTARG";;
    a) ANSIBLE_ARGS="$OPTARG";;
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
ansible-playbook -i ./production ./playbooks/$PLAYBOOK -e \"ansible_ssh_user=$SSH_USERNAME\" $ANSIBLE_ARGS
