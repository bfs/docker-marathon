FROM boritzio/docker-mesosphere-base

RUN apt-get install -y marathon

ADD start_marathon.sh /etc/my_init.d/marathon.sh
