FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    zlib1g-dev \
    libicu-dev \
    libonig-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libssl-dev \
    && docker-php-ext-install \
    intl \
    pdo_mysql \
    zip \
    gd \
    bcmath \
    opcache

RUN docker-php-ext-install mysqli pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./providence/ /var/www/html/
RUN rm -rf /var/www/html/vendor
RUN rm -f /var/www/html/composer.lock
RUN composer install --verbose

RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www/html

COPY ./files/php.ini /usr/local/etc/php/

WORKDIR /var/www/html

EXPOSE 80


