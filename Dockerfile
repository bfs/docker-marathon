FROM boritzio/docker-mesosphere-base

ADD start_marathon.sh /usr/sbin/marathon

EXPOSE 8080

ENTRYPOINT /usr/sbin/marathon
