FROM boritzio/docker-mesosphere-base

RUN apt-get update; apt-get install -y marathon

EXPOSE 8080

ADD start_marathon.sh /etc/my_init.d/marathon.sh
