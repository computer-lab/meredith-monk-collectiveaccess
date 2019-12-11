#!/bin/bash
set -e
chown -R www-data:www-data /media
rm -f /var/run/apache2/apache2.pid
exec "$@"
