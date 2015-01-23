FROM ubuntu:14.04

RUN echo "deb http://repos.mesosphere.io/ubuntu/ trusty main" > /etc/apt/sources.list.d/mesosphere.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    apt-get update

RUN apt-get update && apt-get -y install marathon 

ADD start_marathon.sh /usr/local/sbin/marathon

EXPOSE 8080

ENTRYPOINT /usr/local/sbin/marathon
