FROM debian:12-slim

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get -y install python3-gps gpsd-clients chrony python3-gi-cairo libgps-dev

COPY chrony.conf /etc/chrony/chrony.conf

COPY gpsd /etc/default/gpsd

COPY startup.sh /bin/startup.sh

EXPOSE 123/udp

HEALTHCHECK CMD chronyc tracking || exit 1

ENTRYPOINT ["/bin/startup.sh"]
