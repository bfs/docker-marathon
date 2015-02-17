#!/bin/bash

/usr/bin/java -Xmx512m \
-Djava.library.path=/usr/local/lib:/usr/lib:/usr/lib64 \
-Djava.util.logging.SimpleFormatter.format=%2$s%5$s%6$s%n \
-cp /usr/bin/marathon mesosphere.marathon.Main \
--zk $MARATHON_ZK --master $MARATHON_MASTER --hostname $MARATHON_HOSTNAME