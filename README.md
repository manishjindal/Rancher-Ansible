# Rancher-Ansible

This playbook will install Rancher platform (latest version) and register hosts automatically with Rancher, this playbook can be used to automatically create hosts on AWS using cloudformation or to install Rancher and register hosts on already created hosts using static inventory file.

The playbook can be used to set up Rancher environment without manually registering each host with Rancher server.

## Components

This setup consists of 3 main roles:

- **Docker Role**

The Docker role will be responsible of installing Docker on the host, the role support installation on Debian/RHEL systems, and also you can specify the desired version to be installed through the vars files for each OS type.

- **Rancher Role**

The Rancher role is responsible of running th Rancher server container with the specific rancher server version.


- **rancher_reg Role**

This role will run the fetch the registration command from the Rancher server and run the rancher agent container.

### AWS

To use the AWS playbook, you have to first configure the aws variable file, located in [providers/aws/vars/aws_vars.yml](aws_vars.yml):

```
---

aws_stack_name: "rancher-stack"
aws_region: "eu-central-1"
aws_az: "eu-central-1b"
aws_rancher_ami: "ami-3f1bd150"
aws_rancher_instance_type: "t2.small"
aws_vpc_id: "xxxxxxx"
aws_key_pair: "hussein"
aws_agent_count: "2"
aws_max_agent_count: "3"
aws_agent_ami: "ami-3f1bd150"
aws_agent_instance_type: "t2.micro"
aws_subnet_id: "xxxxxxxxx"

rancher_server: "{{ hostvars[groups['tag_InventoryName_<aws_stack_name>_rancher_server'][0]]['ansible_ssh_host'] }}"
rancher_version: v1.5.3
rancher_port: 8080
rancher_server_user: ubuntu
rancher_agents_user: ubuntu

```

#### Input variables

- `aws_stack_name`

This will be used as the cloudformation stack name, you should set this name also in `rancher_server` variable.

- `aws_region`

The region where the cloudformation stack will be deployed.

- `aws_az`

The availability zone name

- `aws_rancher_ami`

The AMI that will be used for the Rancher server, this is also related to the `rancher_server_user` variable, you should set the right user to be used by Ansible to ssh to the Rancher server host, for example for RedHat AMI you should set the user to `ec2-user`.

- `aws_rancher_instance_type`

The EC2 instance type that will be used for the Rancher server.

- `aws_vpc_id`

The VPC where the cloudformation stack will be deployed, note that the playbook doesn't currently create a custom vpc however you can choose the vpc using this variable.

- `aws_key_pair`

The EC2 key pair that will be set on all of the hosts.

- `aws_agent_count`

The number of agent instances that will be created and registered to the Rancher server.

- `aws_max_agent_count`

The max agent count for the Autoscaling group for Rancher agents.

- `aws_agent_ami`

The AMI that will be used for the Rancher agents, this is also related to the `rancher_agents_user` variable, you should set the right user to be used by Ansible to ssh to the Rancher server host, for example for RedHat AMI you should set the user to `ec2-user`.

- `aws_agent_instance_type`

The EC2 instance type that will be used for the Rancher agents.

- `aws_subnet_id`

The subnet where that will be used to deploy the rancher agents and server.

- `rancher_server`

The Rancher server endpoint, this variable by default uses the magic ansible variables to point to the Rancher server host, where it searches for a Ansible group `tag_InventoryName_<aws_stack_name>_rancher_server` this tag is added by default in the cloudformation template.

- `rancher_version`

The Rancher server version.

- `rancher_port`

The Rancher server port that will be exposed on the host.


#### Usage

The AWS playbook uses the AWS [dynamic inventory](https://aws.amazon.com/blogs/apn/getting-started-with-ansible-and-dynamic-amazon-ec2-inventory-management/), so before using the playbook you should set the right credentials to be used with inventory:

```
$ export AWS_ACCESS_KEY_ID='YOUR_AWS_API_KEY'
$ export AWS_SECRET_ACCESS_KEY='YOUR_AWS_API_SECRET_KEY'
```
Then you should execute the following command to run the playbook:

```
$ ansible-playbook -i providers/aws/inventory/ec2.py aws.yml
```

### Static Deployment

If you prefer to just run the roles on existing hosts, you can choose the `other.yml` file to run.

#### Usage

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

- Run the ansible-playbook command to setup the environment:

```
# ansible-playbook -u user -i providers/other/inventory/hosts rancher.yml
```
