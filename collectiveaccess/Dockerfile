FROM ubuntu:18.04

ENV APACHE_RUN_USER     www-data
ENV APACHE_RUN_GROUP    www-data
ENV APACHE_LOG_DIR      /var/log/apache2
ENV APACHE_PID_FILE     /var/run/apache2.pid
ENV APACHE_RUN_DIR      /var/run/apache2
ENV APACHE_LOCK_DIR     /var/lock/apache2
ENV APACHE_LOG_DIR      /var/log/apache2

ENV CA_PROVIDENCE_VERSION=1.7.8
ENV CA_PROVIDENCE_DIR=/var/www/providence
ENV CA_PAWTUCKET_VERSION=1.7
ENV CA_PAWTUCKET_DIR=/var/www

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y apache2 \
					php7.0 \
					libapache2-mod-php \
					curl \
					php-mysql \
					mysql-client \
					curl \
					php-curl \
					php-xml \
					zip \
					wget \
					ffmpeg \
					ghostscript \
					imagemagick \
					php-gd \
					libreoffice \
					php-zip \
					vim

#GMAGICK
RUN apt-get install -y php-pear php-dev graphicsmagick libgraphicsmagick1-dev php-gmagick
# && pecl install gmagick-2.0.4RC1

# better PDF (wkhtmltopdf)
RUN wget https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb && apt install -y ./wkhtmltox_0.12.5-1.bionic_amd64.deb


RUN curl -SsL https://github.com/collectiveaccess/providence/archive/$CA_PROVIDENCE_VERSION.tar.gz | tar -C /var/www/ -xzf -
RUN mv /var/www/providence-$CA_PROVIDENCE_VERSION /var/www/providence

RUN curl -SsL https://github.com/collectiveaccess/pawtucket2/archive/$CA_PAWTUCKET_VERSION.tar.gz | tar -C /var/www/ -xzf -
RUN mv $CA_PAWTUCKET_DIR/pawtucket2-$CA_PAWTUCKET_VERSION/* /var/www
RUN cd $CA_PAWTUCKET_DIR && cp setup.php-dist setup.php

RUN sed -i "s@DocumentRoot \/var\/www\/html@DocumentRoot \/var\/www@g" /etc/apache2/sites-available/000-default.conf
RUN rm -rf /var/www/html
run mkdir /$CA_PROVIDENCE_DIR/media/collectiveaccess
RUN ln -s /$CA_PROVIDENCE_DIR/media /$CA_PAWTUCKET_DIR/media


COPY files/php.ini /etc/php/7.0/apache2/php.ini
COPY files/setup.php /$CA_PROVIDENCE_DIR/setup.php
COPY files/entrypoint.sh /entrypoint.sh
RUN chown -R www-data:www-data /var/www

RUN chmod 777 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD [ "/usr/sbin/apache2", "-DFOREGROUND" ]