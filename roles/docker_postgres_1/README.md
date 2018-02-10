# docker_postgres
This role serves to spin up and manage PostgreSQL Docker containers.

## How To Use
1. Add your Postgres configurations to Ansible inventory, use `playbooks/roles/docker_postgres/defaults/main.yml` as a reference.
2. Add your host to the `[docker_postgres]` host group in Ansible inventory
3. Execute Ansible.
