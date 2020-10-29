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
 - vim hosts

# Update SSH Key File Path:
 - vim hosts

# Deploy Public Key to all hosts
 - rm /home/atingupta2005/.ssh/known_hosts
 - ansible-playbook playbooks/1-deploy-ssh-key-to-remote.yml --ask-pass --check

# Test Ansible is able to conenct to all hosts
 - ansible all  --module-name ping -u atin --check

# Set Sudoers
 - ansible-playbook playbooks/2-set_sudoer.yml -b -K --check

# Install Neo4J
 - ansible-playbook  playbooks/3-install-neo4j.yml --check

# Prepare Neo4J Cluster Config
 - cd prepare-neo4j-cluster-config
 - chmod a+x neo4j.conf.inc.sh && ls
 - vim neo4j.conf.inc.sh
	#Update host names
 - ./neo4j.conf.inc.sh
 #Note many Configuration files each for a host will be created.
 #It will copy all these newly created files and paste in "../playbooks/files/neo4j-config" folder
  - tree ../playbooks/files/neo4j-config
  - cd ..		# Move back to parent folder
# Install Neo4J Cluster
 - ansible-playbook  playbooks/4-cluster-install-neo4j.yml --check

# Restart Cluster
 - ansible-playbook  playbooks/5-restart-neo4j.yml --check

# Stop Cluster
 - ansible-playbook  playbooks/6-stop-neo4j.yml --check

# Reset Cluster - Not working
 - ansible-playbook  playbooks/7-unbind-neo4j-cluster.yml --check
 
 
# Other Usefull Commands:
ansible all -i 'vm1,' -m ping -u ubuntu   --check   # Run command on specific host using host aliases
ansible all -i 'vm1,' -m ping -u ubuntu    --check  # Run command on specific host using host aliases

#Run playbook on limited hosts using host aliases
ansible-playbook  playbooks/6-stop-neo4j.yml --limit "vm1,vm2"   --check

ansible  -a "/var/lib/neo4j/bin/neo4j stop" neo4jservers --limit "host1,host2"  --check

ansible  -a "tail -n 20 /var/lib/neo4j/conf/neo4j.conf" neo4jservers  --check

ansible  -a "/var/lib/neo4j/bin/neo4j start" neo4jservers  --check

ansible  -a "/var/lib/neo4j/bin/neo4j status" neo4jservers  --check

ansible  -a "/var/lib/neo4j/bin/neo4j stop" neo4jservers  --check

ansible  -a "/var/lib/neo4j/bin/neo4j-admin unbind" neo4jservers  --check

ansible  -a "sudo rm -rf /data/*" neo4jservers  --check

ansible  -a "ls -al /data/" neo4jservers  --check

ansible-playbook  playbooks/unbind-neo4j-cluster.yml  --check

ansible  -a "tail -n 20 /logs/debug.log" neo4jservers  --check

ansible  -a "curl localhost:7474" neo4jservers  --check

ansible  -a "/var/lib/neo4j/bin/neo4j stop && /var/lib/neo4j/bin/neo4j-admin unbind" neo4jservers  --check