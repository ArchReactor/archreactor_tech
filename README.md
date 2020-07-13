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
Looking in [ansible/production](ansible/production) is a good place to see what software is on what server.

# Architecture
The basic idea is that most services are running in Docker containers. The Docker containers are then deployed and managed by Ansible. Other server settings are also handled by Ansible. Some refer to this as DevOps or IaC (infrastructure as code). Also the work is being done publicly. This is to encourage participation by Arch Reactor members and public in general.

# Monitoring
http://sensu.archreactor.net

http://archreactor.org:3000

Sensu is used for motoring web services and server resources. Alerts are sent to the Arch Reactor slack channel #alerts. https://archreactor.slack.com

Monitor driven development is recommended. Create a Sensu check for a service first. This insures that the alert system works. Then bring up the service to resolve the Sensu check. Ensuring that the monitoring system is fully covering the network.

# Users
https://users.archreactor.net

Users are managed by Keycloak

Keycloak updates the ldap samba server at: ad.archreactor.net

http://ldap.archreactor.net

Applications like Wordpress and Drupal authenticate with Keycloak using OpenIDConnect. Other applications like Snipe-IT use ldap.

Keyclock settings can be found at [docs/KEYCLOAK.md](docs/KEYCLOAK.md)

# Jenkins and Backups
http://jenkins.archreactor.net
http://archreactor.org:8080

Jenkins handles backups and cron style jobs.

Backups are stored in /srv/rsync/backups
They are then synced between servers for extra safety.

# Arch Reactor API
http://api.archreactor.net

https://github.com/ArchReactor/archreactor_api

API server acts as middleware for other APIs like CivicCRM and Snipe-IT

# Testing
Test are located in /tests folder. Vagrant is used to launch virtual Ubuntu servers and a workstation using Virtual Box. See [tests/README.md](tests/README.md) for more details.