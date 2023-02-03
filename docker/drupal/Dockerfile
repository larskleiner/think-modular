FROM drupal:php8.1

### drush specific variables
ARG DRUSH_DIR="/usr/share/apache2"
ARG DRUSH_LAUNCHER_URL="https://github.com/drush-ops/drush-launcher/releases/download/0.10.1/drush.phar"

RUN apt-get update \
    && apt-get install default-mysql-client -y \
    && apt-get install git -y

RUN pecl install -o -f redis \
  &&  rm -rf /tmp/pear \
  &&  docker-php-ext-enable redis

WORKDIR /opt/drupal/web

COPY ./vendor vendor
COPY ./html html
COPY ./config config
COPY ./tmp tmp

COPY ./composer.json composer.json
COPY ./load.environment.php load.environment.php

COPY ./docker/drupal/ports.conf /etc/apache2/
COPY ./docker/drupal/000-default.conf /etc/apache2/sites-available/
COPY ./docker/drupal/php.ini /usr/local/etc/php/php.ini

RUN chown -R www-data:www-data .

## Install drush
RUN curl -kOL "${DRUSH_LAUNCHER_URL}" \
	&& chmod +x drush.phar \
	&& mv drush.phar /usr/local/bin/drush \
	&& mkdir -p $DRUSH_DIR/.drush

EXPOSE 8080
