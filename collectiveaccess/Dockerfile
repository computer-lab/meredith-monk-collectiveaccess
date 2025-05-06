FROM php:8.2-apache

ENV PROVIDENCE_DIR=/var/www/html

RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    wget \
    git \
    zlib1g-dev \
    libicu-dev \
    libonig-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libssl-dev \
    libmagickwand-dev \
    ghostscript \
    ffmpeg \
    imagemagick \
    graphicsmagick \
    libgraphicsmagick1-dev \
    && pecl install imagick \
    && docker-php-ext-install \
    intl \
    pdo_mysql \
    mysqli \
    zip \
    gd \
    bcmath \
    opcache \
    && docker-php-ext-enable imagick

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./web/ /var/www/html/

RUN composer install --verbose

RUN a2enmod rewrite
RUN chown -R www-data:www-data $PROVIDENCE_DIR

COPY files/php.ini /usr/local/etc/php/
COPY files/setup.php $PROVIDENCE_DIR/setup.php
COPY files/app.conf $PROVIDENCE_DIR/app/conf/app.conf
COPY files/browse.conf $PROVIDENCE_DIR/app/conf/browse.conf
COPY files/media_processing.conf $PROVIDENCE_DIR/app/conf/media_processing.conf
COPY files/services.conf $PROVIDENCE_DIR/app/conf/services.conf
#COPY files/multipart_id_numbering.conf $PROVIDENCE_DIR/app/conf/multipart_id_numbering.conf


WORKDIR $PROVIDENCE_DIR

EXPOSE 80



