#!/bin/bash

set -e

#exec "$@"

# must be run as root
service incron start

# temporarily disabled until login will work (--system must be used to override existing user but does not allow login)
#su - mosquitto

/usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf

