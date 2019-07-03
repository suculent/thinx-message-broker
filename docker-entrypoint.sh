#!/bin/bash

set +e

echo "Starting cron..."

cron -f &

echo "Starting incron..."

# must be run as root
incrond --foreground &
incrontab --reload
incrontab -l

echo "Switching to service user..."
touch /mqtt/log/mosquitto.log
chown -R mosquitto:mosquitto /mqtt

su mosquitto -s /bin/bash

echo "MQTT config:"
cat /mqtt/config/mosquitto.conf
echo ""

echo "Starting MQTT broker..."
/usr/sbin/mosquitto -v -c /mqtt/config/mosquitto.conf

echo "MQTT broker exited..."
