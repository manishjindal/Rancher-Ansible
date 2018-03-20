
# Run Playbook 
For Quick start use below command 
```
ansible-playbook -i providers/other/inventory/hosts rancher-1.6.yml --extra-vars "ansible_sudo_pass=sudo-password"
```

For Details please follow the documentation.


# Rancher-Ansible

This playbook will install Rancher platform (1.6.14) and register hosts automatically with Rancher.

The playbook can be used to set up Rancher environment without manually registering each host with Rancher server.



## Components

This setup consists of 3 main roles:

- **Docker Role**

The Docker role will be responsible of installing Docker on the host, the role support installation on Debian/RHEL systems, and also you can specify the desired version to be installed through the vars files for each OS type.

- **Rancher Role**

The Rancher role is responsible of running th Rancher server container with the specific rancher server version.


- **rancher_reg Role**

This role will run the fetch the registration command from the Rancher server and run the rancher agent container.



## Static Deployment

We are using static deployment where all the nodes are on premise.

We need to edit following files with correct node information.

- playbook rancher-1.6.yml
- providers/other/inventory/host
- providers/other/vars/<vars-file> (vars-file as mentioned in playbook)



#### Playbook

```
ansible-playbook -i providers/other/inventory/hosts rancher-1.6.yml --extra-vars "ansible_sudo_pass=sudo-password"

```


#### Inventory/host

- Add the connection information for the Rancher server under the [rancher] group:
```
[Rancher]
rancher ansible_ssh_port=22 ansible_ssh_host=x.x.x.x
```

- Add all the nodes that will be registered with Rancher under the [Agents] group:

```
[Agents]
agent1 ansible_ssh_port=22 ansible_ssh_host=y.y.y.y
agent2 ansible_ssh_port=22 ansible_ssh_host=z.z.z.z
```


#### Vars File

Modify following values in vars file.

```
rancher_server: <RANCHER SERVER IP ADDRESS>

```
ffsd
