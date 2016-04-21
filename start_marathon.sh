#!/bin/bash

#defaults for required flags
export MARATHON_HOSTNAME=${MARATHON_HOSTNAME:-${HOSTNAME:-`hostname`}}
export MARATHON_HTTP_PORT=${MARATHON_HTTP_PORT:-${PORT:-8080}}
export MARATHON_MASTER=${MARATHON_MASTER:-"zk://localhost:2181/mesos"}
export MARATHON_ZK=${MARATHON_ZK:-"zk://localhost:2181/marathon"}

MARATHON_STARTUP_FLAGS="--zk $MARATHON_ZK --master $MARATHON_MASTER --hostname $MARATHON_HOSTNAME --http_port $MARATHON_HTTP_PORT"

# optional flags
if [ ! -z "$MARATHON_MESOS_ROLE" ]; then
  MARATHON_STARTUP_FLAGS+=" --mesos_role $MARATHON_MESOS_ROLE"
fi

if [ ! -z "$MARATHON_MESOS_AUTHENTICATION_PRINCIPAL" ] && [ ! -z "$MARATHON_MESOS_AUTHENTICATION_SECRET" ]; then
  echo -n "$MARATHON_MESOS_AUTHENTICATION_SECRET" > /mesos_auth_secret
  chmod 600 /mesos_auth_secret
  MARATHON_STARTUP_FLAGS+=" --mesos_authentication_principal $MARATHON_MESOS_AUTHENTICATION_PRINCIPAL --mesos_authentication_secret_file /mesos_auth_secret"
fi

echo "-------Marathon Host ENV Variables-------"
env
echo "----end Marathon Host ENV Variables----"

/usr/bin/java -Xmx512m \
-Djava.library.path=/usr/local/lib:/usr/lib:/usr/lib64 \
-Djava.util.logging.SimpleFormatter.format=%2$s%5$s%6$s%n \
-cp /usr/bin/marathon mesosphere.marathon.Main \
$MARATHON_STARTUP_FLAGS
