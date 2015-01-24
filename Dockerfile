FROM boritzio/docker-mesos-master

RUN apt-get update && apt-get -y install marathon 

ADD start_marathon.sh /usr/sbin/marathon

EXPOSE 8080

ENTRYPOINT /usr/sbin/marathon
