# Detailed instructions are below
ansible –version

sudo apt -y install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible

ansible –version

#Ansible config file
cat vim /etc/ansible/ansible.cfg

ansible_python_interpreter=/usr/bin/python3

#Ansible Inventory file
cat /etc/ansible/hosts

#ssh-keygen
ssh-keygen -f ~/.ssh/neo4j_id_rsa
chmod 0600 ~/.ssh/neo4j_id_rsa

ls -al ~/.ssh

#After the public key of our Ansible server is generated, we have to copy it to the nodes, using this command:
ssh-copy-id -i <username>@<IP address of our node machine>
#Note: We can also copy the ssh key to all the remote machines using Ansible Playbook

#Test the key
ssh -i ~/.ssh/neo4j_id_rsa <username>@<IP address of our node machine>
	- ssh -i ~/.ssh/neo4j_id_rsa traininguser@atingupta-20201027-vm1.eastus.cloudapp.azure.com


mkdir ~/ansible-project
cp /etc/ansible/hosts ~/ansible-project/hosts

#Update Hosts:
#Update SSH Key File Path:
vim hosts
	[neo4jservers]
	atingupta-20201027-vm1.eastus.cloudapp.azure.com
	atingupta-20201027-vm2.eastus.cloudapp.azure.com
	atingupta-20201027-vm3.eastus.cloudapp.azure.com
	atingupta-20201027-vm4.eastus.cloudapp.azure.com
	atingupta-20201027-vm5.eastus.cloudapp.azure.com

	[neo4jservers:vars]
	ansible_python_interpreter=/usr/bin/python3
	ansible_user=atin
	ansible_ssh_private_key_file = ~/.ssh/neo4j_id_rsa
	ansible_connection=ssh
	ansible_port=22
	
:wq

#To deploy generated SSH key to all remote hosts at once
vim playbooks/deploy-ssh-key-to-remote.yml
---
- hosts: all
  remote_user: atin
  tasks:
  # upload ssh key                
  - authorized_key:
	  user: atin
	  state: present
	  manage_dir: yes
	  key: "{{ lookup('file', '~/.ssh/neo4j_id_rsa.pub') }}"
# vim:ft=ansible:
:wq

vim ansible.cfg		# Change or add below lines
	[defaults]
	host_key_checking = False
	inventory      = hosts
:wq

ansible-playbook playbooks/deploy-ssh-key-to-remote.yml --ask-pass


ansible all  --module-name ping -u traininguser
ansible all  -a "hostname"

#Make Sudoers access on all Remote VMs
cd ~/ansible-project
mkdir set-sudoers
vim set-sudoers/set-sudoers/set_sudoer.yml
	---
	- hosts: all
	  tasks:
		- lineinfile:
			path: /etc/sudoers
			state: present
			regexp: '^%sudo'
			line: '%sudo ALL=(ALL) NOPASSWD: ALL'
			validate: 'visudo -cf %s'
:we

ansible-playbook  ./set-sudoers/set_sudoer.yml -b -K

mkdir playbooks

vim playbooks/install-neo4j.yml
	- Refer to the actual file content for details


#Install Neo4J on All Remote VMs
ansible-playbook  playbooks/install-neo4j.yml
