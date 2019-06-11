#!/bin/bash

set -e

#exec "$@"

# must be run as root
service incron start
#/usr/sbin/incrond -f /etc/incron.conf --foreground &&

su - mosquitto

/usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf

