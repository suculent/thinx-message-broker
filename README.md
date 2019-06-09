# thinx-message-broker

Expects root data folder at /mnt/data/mosquitto with following contents:

* mosquitto.conf
* thinx.pw
* thinx.acl

Remove `listen 8883` from config or add certificates for SSL configuration:

* ca.pem

* cert.pem

* privkey.pem

> Certificates must match domain called from device firmware!