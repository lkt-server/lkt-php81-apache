FROM php:8.1-apache-buster

# Configure document root
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Enable mod rewrite
RUN a2enmod rewrite ssl

# Enable PHP extensions for databases
RUN docker-php-ext-install pdo pdo_mysql mysqli

# LDAP Installation
RUN apt-get update \
 && apt-get install libldap2-dev -y \
 && rm -rf /var/lib/apt/lists/* \
 && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
 && docker-php-ext-install ldap

# Setup user group
RUN usermod -u 431 www-data

# Add zip support
RUN set -eux; apt-get update; apt-get install -y libzip-dev zlib1g-dev; docker-php-ext-install zip

# Add MariaDB client
RUN apt-get install -y mariadb-client

# Add IMAP support
RUN apt-get update && apt-get install -y libc-client-dev libkrb5-dev && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap

# Add intl support
RUN apt-get -y update; apt-get install -y libicu-dev; docker-php-ext-configure intl; docker-php-ext-install intl

# Generates server info files
RUN echo "<?php phpinfo(); ?>" > /var/www/html/info.php\
    && php -m > /var/www/html/php1.html