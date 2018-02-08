# docker_artifactory
This role serves to spin up and manage Artifactory Docker containers.

## How To Use
1. Add your Artifactory configurations to Ansible inventory, use `playbooks/roles/docker_artifactory/defaults/main.yml` as a reference.
2. Add your host to the `[docker_artifactory]` host group in Ansible inventory
3. Execute Ansible.
