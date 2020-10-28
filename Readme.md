# In short run below:
 - git clone https://github.com/atingupta2005/ansible-neo4j.git
 - cd ansible-neo4j
 - sudo apt -y install software-properties-common
 - sudo apt-add-repository ppa:ansible/ansible
 - sudo apt update
 - sudo apt install ansible

# ssh-keygen
 - ssh-keygen -f ~/.ssh/neo4j_id_rsa
 - chmod 0600 ~/.ssh/neo4j_id_rsa

# Test the key
 - ssh -i ~/.ssh/neo4j_id_rsa <username>@<hostname>

# Update Hosts:
 - vim ~/ansible-project/inventory.ini

# Update SSH Key File Path:
 - vim ~/ansible-project/inventory.ini

# Deploy Public Key to all hosts
 - ansible-playbook -i ~/ansible-project/inventory.ini playbooks/deploy-ssh-key-to-remote.yml --ask-pass

# Test Ansible is able to conenct to all hosts
 - ansible all --inventory-file=~/ansible-project/inventory.ini --module-name ping -u atin

# Set Sudoers
 - ansible-playbook -i inventory.ini ./set-sudoers/set_sudoer.yml -b -K

# Install Neo4J
 - ansible-playbook --inventory-file=~/ansible-project/inventory.ini playbooks/install-neo4j.yml

# Reset Cluster - Not working
 - ansible-playbook --inventory-file=~/ansible-project/inventory.ini playbooks/unbind-neo4j-cluster.yml