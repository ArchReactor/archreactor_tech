# Archreactor
Server setup and configuration for Archreactor (archreactor.org)

# Requirements
- Linux System
- Ansible
- SSH credentials for Archreactor servers
- Ansible Vault password

# Deploying
```deploy.sh```

The deploy script has a few options. Like changing your username or choosing a specific playbook. ```deploy.sh -h``` for usage

Deploy script runs the Ansible playbook anisble/playbooks/site.yml using ansible/production as a list of hosts. 
Secrets are kept in ansible/vault. They are decrypted with the deploy.sh script using ansible-vault. You can prompt for the vault password with `-k` or keep it in your home directory as .vault_pass.txt

# Users
https://users.archreactor.net

Users are managed by Keycloak

Keycloak updates the ldap samba server at: ad.archreactor.net

http://ldap.archreactor.net

Applications like Wordpress and Drupal authenticate with Keycloak using OpenIDConnect. Other applications like Snipe-IT use ldap.