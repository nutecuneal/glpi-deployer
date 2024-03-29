FROM php:8.2.9-apache-bookworm

# GLP URI (file, Link)
ARG GLPI_SOURCECODE_URI=https://github.com/glpi-project/glpi/releases/download/10.0.9/glpi-10.0.9.tgz

# install-php-extensions URL
ARG INSTALL_PHP_EXT_URL=https://github.com/mlocati/docker-php-extension-installer/releases/download/2.1.16/install-php-extensions

# User and Group ID
ARG PUID=1024
ARG PGID=1024

# Set path "PHP" 
ARG PHP_CONF_PATH=/usr/local/etc


ADD ${INSTALL_PHP_EXT_URL} /usr/local/bin
ADD ${GLPI_SOURCECODE_URI} /tmp

WORKDIR /var/www/html

RUN apt-get update -y && \
    chmod +x /usr/local/bin/install-php-extensions && \ 
    install-php-extensions gd xdebug mysqli intl ldap xmlrpc apcu exif bz2 zip opcache && \
    rm -rf /etc/apache2/sites-enabled/* /etc/apache2/sites-available/* /var/log/apache2/* && \
    ([ -d /tmp/glpi ] || tar -xf /tmp/glpi*.tgz -C /tmp) && mv /tmp/glpi/* ./ && \
    mkdir /utils && mv /var/www/html/install /utils

COPY configs/app/downstream.php ./inc
COPY configs/php/php.ini ${PHP_CONF_PATH}/php
COPY configs/apache/sites-available/*.conf /etc/apache2/sites-available

RUN groupadd -g ${PGID} app && \
    useradd -u ${PUID} -g app -G www-data -M -c applications -s /bin/bash app && \
    mkdir -m 755 /etc/glpi /var/lib/glpi /var/log/glpi && \
    chmod -R 755 ./ /utils && \
    chown -R app:app ./ /utils /etc/glpi /var/lib/glpi /var/log/glpi && \
    sed -e "s/^: \${APACHE_RUN_USER:=www-data}/: \${APACHE_RUN_USER:=app}/" -i /etc/apache2/envvars && \
    sed -e "s/^: \${APACHE_RUN_GROUP:=www-data}/: \${APACHE_RUN_GROUP:=app}/" -i /etc/apache2/envvars && \
    echo "opcache.memory_consumption=256" >> ${PHP_CONF_PATH}/php/conf.d/docker-php-ext-opcache.ini && \
    a2enmod remoteip rewrite && \
    a2ensite glpi.domain.conf && \
    rm -rf /tmp/*


USER app

EXPOSE 80

VOLUME ["/var/www/html/marketplace", "/etc/glpi", "/var/lib/glpi", "/var/log/glpi", "/var/log/apache2"]

CMD ["apache2ctl", "-D", "FOREGROUND"]
