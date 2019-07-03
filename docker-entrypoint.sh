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

echo ""
echo "MQTT config:"
cat /mqtt/config/mosquitto.conf
echo ""

echo "Starting MQTT broker..."

mosquitto -d -v -c /mqtt/config/mosquitto.conf

sleep 2

ps -ax | grep mosquitto

tail -f /dev/null
