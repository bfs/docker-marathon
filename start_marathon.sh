#!/bin/bash

#defaults

export MARATHON_HOSTNAME=${MARATHON_HOSTNAME:-${HOSTNAME:-`hostname`}}
export MARATHON_HTTP_PORT=${MARATHON_HTTP_PORT:-${PORT:-8080}}
export MARATHON_MASTER=${MARATHON_MASTER:-"zk://localhost:2181/mesos"}
export MARATHON_ZK=${MARATHON_ZK:-"zk://localhost:2181/marathon"}
export MARATHON_MESOS_ROLE=${MARATHON_MESOS_ROLE:-"*"}

echo "-------Marathon Host ENV Variables-------"
env
echo "----end Marathon Host ENV Variables----"


/usr/bin/java -Xmx512m \
-Djava.library.path=/usr/local/lib:/usr/lib:/usr/lib64 \
-Djava.util.logging.SimpleFormatter.format=%2$s%5$s%6$s%n \
-cp /usr/bin/marathon mesosphere.marathon.Main \
 --zk $MARATHON_ZK --master $MARATHON_MASTER --hostname $MARATHON_HOSTNAME --http_port $MARATHON_HTTP_PORT --mesos_role $MARATHON_MESOS_ROLE
