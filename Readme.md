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

# Update Hosts:
 - vim inventory.ini

# Update SSH Key File Path:
 - vim inventory.ini

# Deploy Public Key to all hosts
 - ansible-playbook -i inventory.ini playbooks/1-deploy-ssh-key-to-remote.yml --ask-pass

# Test the key
 - ssh -i ~/.ssh/neo4j_id_rsa <username>@<hostname>

# Test Ansible is able to conenct to all hosts
 - ansible all --inventory-file=inventory.ini --module-name ping -u atin

# Set Sudoers
 - ansible-playbook -i inventory.ini playbooks/2-set_sudoer.yml -b -K

# Install Neo4J
 - ansible-playbook --inventory-file=inventory.ini playbooks/3-install-neo4j.yml

# Install Neo4J Cluster
 - ansible-playbook --inventory-file=inventory.ini playbooks/4-cluster install-neo4j.yml

# Restart Cluster
 - ansible-playbook --inventory-file=inventory.ini playbooks/5-restart-neo4j.yml

# Stop Cluster
 - ansible-playbook --inventory-file=inventory.ini playbooks/6-stop-neo4j.yml

# Reset Cluster - Not working
 - ansible-playbook --inventory-file=inventory.ini playbooks/7-unbind-neo4j-cluster.yml
 
 
# Other Usefull Commands:
ansible all -i 'vm1,' -m ping -u ubuntu    # Run command on specific host using host aliases
ansible all -i 'vm1,' -m ping -u ubuntu    # Run command on specific host using host aliases

ansible-playbook --inventory-file=inventory.ini playbooks/6-stop-neo4j.yml --limit "vm1,vm2"  # Run playbook on limited hosts using host aliases

ansible --inventory-file=inventory.ini -a "/var/lib/neo4j/bin/neo4j stop" neo4jservers --limit "host1,host2"

ansible --inventory-file=inventory.ini -a "tail -n 20 /var/lib/neo4j/conf/neo4j.conf" neo4jservers

ansible --inventory-file=inventory.ini -a "/var/lib/neo4j/bin/neo4j start" neo4jservers

ansible --inventory-file=inventory.ini -a "/var/lib/neo4j/bin/neo4j status" neo4jservers

ansible --inventory-file=inventory.ini -a "/var/lib/neo4j/bin/neo4j stop" neo4jservers

ansible --inventory-file=inventory.ini -a "/var/lib/neo4j/bin/neo4j-admin unbind" neo4jservers

ansible --inventory-file=inventory.ini -a "sudo rm -rf /data/*" neo4jservers

ansible --inventory-file=inventory.ini -a "ls -al /data/" neo4jservers

ansible-playbook --inventory-file=inventory.ini playbooks/unbind-neo4j-cluster.yml

ansible --inventory-file=inventory.ini -a "tail -n 20 /logs/debug.log" neo4jservers

ansible --inventory-file=inventory.ini -a "curl localhost:7474" neo4jservers

ansible --inventory-file=inventory.ini -a "/var/lib/neo4j/bin/neo4j stop && /var/lib/neo4j/bin/neo4j-admin unbind" neo4jservers