# docker-marathon
Docker build for mesos marathon server


### Starting

```bash
docker run --restart=on-failure:10 --name marathon -p 8080:8080 -m 1g -e MARATHON_MASTER=zk://pet100:2181,pet110:2181,pet120:2181/mesos -e MARATHON_ZK=zk://pet100:2181,pet110:2181,pet120:2181/marathon -e MARATHON_HOSTNAME=$(hostname) -e MARATHON_MESOS_ROLE=role_name -e MESOS_AUTHENTICATION_PRINCIPAL=user_name -e MESOS_AUTHENTICATION_SECRET=$(cat /secret_file) boritzio/docker-marathon
```
