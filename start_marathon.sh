#!/bin/bash

/usr/bin/java -Xmx512m \
-Djava.library.path=/usr/local/lib \
-Djava.util.logging.SimpleFormatter.format=%2$s%5$s%6$s%n \
-cp /usr/local/bin/marathon mesosphere.marathon.Main \
--zk $MARATHON_ZK --master $MARATHON_MASTER