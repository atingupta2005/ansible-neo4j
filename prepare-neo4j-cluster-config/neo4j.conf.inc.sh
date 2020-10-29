#!/bin/bash

function join_by { local d=$1; shift; local f=$1; shift; printf %s "$f" "${@/#/$d}"; }
 
# Declare an array of string with type
declare -a StringArray=("ag-20201029-vm1.eastus.cloudapp.azure.com" "ag-20201029-vm2.eastus.cloudapp.azure.com" "ag-20201029-vm3.eastus.cloudapp.azure.com" "ag-20201029-vm4.eastus.cloudapp.azure.com" "ag-20201029-vm5.eastus.cloudapp.azure.com" )
 
all_hosts=$(join_by :5000, ${StringArray[@]})
all_hosts="${all_hosts}:5000"
echo $all_hosts

i=1
# Iterate the string array using for loop
for host in ${StringArray[@]}; do
   echo $host
   hostfilename=vm$i.inc.neo4j.conf
   echo $hostfilename
   rm -rf $hostfilename
   cp neo4j.conf.template.txt $hostfilename
   
   sed -i "s/<hostname>/$host/g" $hostfilename
   sed -i "s/<allhostnames>/$all_hosts/g" $hostfilename
   
   ((i=i+1))
done

cp *.neo4j.conf ../playbooks/files/neo4j-config

# cp neo4j.conf.template.txt neo4j.conf.inc.vm1.txt
# sed -i 's/<hostname>/hostname_vm1/g' neo4j.conf.inc.vm1.txt
# sed -i 's/<hostname1>/hostname1_vm1/g' neo4j.conf.inc.vm1.txt
# sed -i 's/<hostname2>/hostname1_vm2/g' neo4j.conf.inc.vm1.txt
# sed -i 's/<hostname3>/hostname1_vm3/g' neo4j.conf.inc.vm1.txt
# sed -i 's/<hostname4>/hostname1_vm4/g' neo4j.conf.inc.vm1.txt
# sed -i 's/<hostname5>/hostname1_vm5/g' neo4j.conf.inc.vm1.txt
