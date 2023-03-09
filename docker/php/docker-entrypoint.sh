#!/bin/sh

chown -R www-data:www-data /var/www/app

# Execute default entrypoint
docker-php-entrypoint $@
