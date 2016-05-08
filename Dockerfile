FROM boritzio/docker-mesosphere-base

RUN apt-get install -y marathon

EXPOSE 8080

ADD default /etc/default/marathon

ADD start.sh /etc/my_init.d/

VOLUME ["/config"]