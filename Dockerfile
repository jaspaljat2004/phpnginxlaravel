FROM php:8.1-fpm

RUN apt-get update && \
    apt-get install -y \
    curl \
    vim \
    sudo \
    nginx \
    zip \
    supervisor



ARG VERSION_COMPOSER=2.1.8

RUN curl -O https://getcomposer.org/download/"${VERSION_COMPOSER}"/composer.phar \
     && chmod a+x composer.phar \
     && mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/laravel
ADD default/laravel /var/www/laravel
RUN composer update
ADD default/default.conf /etc/nginx/conf.d/default.conf
ADD default/default.conf /etc/nginx/sites-enabled/default
ADD default/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod 777 -R /var/www/laravel/storage
CMD ["/usr/bin/supervisord"]

