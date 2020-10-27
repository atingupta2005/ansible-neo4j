cd $NEO4J_HOME/conf && git add * && git commit -am "-"
export NEO4J_EDITION=enterprise
export NEO4J_HOME="/var/lib/neo4j"
export NEO4J_ACCEPT_LICENSE_AGREEMENT=yes
PATH="${NEO4J_HOME}"/bin:$PATH
ulimit -n 60000
neo4j stop
neo4j start