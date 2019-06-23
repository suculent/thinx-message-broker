FROM debian:jessie

RUN apt-get update && apt-get install -y wget apt-transport-https incron nano apt-utils && \
    wget -q -O - https://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | gpg --import && \
    gpg -a --export 8277CCB49EC5B595F2D2C71361611AE430993623 | apt-key add - && \
    wget -q -O /etc/apt/sources.list.d/mosquitto-jessie.list https://repo.mosquitto.org/debian/mosquitto-jessie.list && \
    apt-get update && apt-get install -y mosquitto mosquitto-clients && \
    adduser --system --disabled-password --shell /bin/bash mosquitto && \
    apt-get clean

COPY ./config/mosquitto.conf /etc/mosquitto/conf.d/mosquitto.conf
COPY ./mqtt_restart.sh /mqtt_restart.sh
RUN echo "mosquitto" > /etc/incron.allow && \
    echo "root" >> /etc/incron.allow && \
    mkdir -p /var/spool/incron && \
    chmod +x /mqtt_restart.sh
COPY ./incron.cfg /var/spool/incron/root
RUN chown root:incron /var/spool/incron/root

RUN chown -R mosquitto:mosquitto /var/log/mosquitto

EXPOSE 1883 8883 9001

ADD ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
