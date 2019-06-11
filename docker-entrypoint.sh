#!/bin/sh

set -e

incrontab --reload

exec "$@"
