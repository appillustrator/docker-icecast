FROM ubuntu:trusty

MAINTAINER Manfred Touron "m@42.am"

ENV DEBIAN_FRONTEND noninteractive

RUN sh -c "echo deb http://download.opensuse.org/repositories/multimedia:/xiph/xUbuntu_14.04/ ./ >>/etc/apt/sources.list.d/xiph.list" && \
    wget -qO - http://icecast.org/multimedia-obs.key | sudo apt-key add - && \
    apt-get update && \
    apt-get install -y icecast2

RUN easy_install supervisor && \
    easy_install supervisor-stdout

CMD ["/start.sh"]
EXPOSE 8000
VOLUME ["/config", "/var/log/icecast2", "/etc/icecast2"]

ADD ./start.sh /start.sh
ADD ./etc /etc
RUN chown -R icecast2 /etc/icecast2
