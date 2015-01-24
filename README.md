# docker-marathon
Docker build for mesos marathon server


### Starting

```bash
docker run --restart=on-failure:10 --name marathon -p 8080:8080 -m 1g -e MESOS_ZK=zk://ops100:2181,ops110:2181,ops120:2181/mesos -e MARATHON_ZK=zk://ops100:2181,ops110:2181,ops120:2181/marathon boritzio/docker-marathon
```