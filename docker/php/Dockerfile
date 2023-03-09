FROM php:8.2-fpm-alpine3.17

# define user to map
ARG USER_ID
ARG GROUP_ID

RUN apk add --update nodejs npm yarn

# add usermod / groupmod utils
RUN apk add shadow

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions apcu intl mongodb-stable opcache pcov

RUN wget https://getcomposer.org/installer -O - | php -- --install-dir=/usr/local/bin --filename=composer

ADD php.ini /usr/local/etc/php/php.ini
ADD php-fpm.conf /usr/local/etc/php-fpm.conf

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

WORKDIR /var/www/app

# Map www-data to OS user
RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    usermod --uid ${USER_ID} www-data && \
    groupmod --gid ${GROUP_ID} www-data \
;fi

EXPOSE 9000

ENTRYPOINT [ "docker-entrypoint" ]
CMD ["php-fpm", "-F", "-R"]
