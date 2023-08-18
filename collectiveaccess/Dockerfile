FROM ubuntu:20.04

ENV APACHE_RUN_USER     www-data
ENV APACHE_RUN_GROUP    www-data
ENV APACHE_LOG_DIR      /var/log/apache2
ENV APACHE_PID_FILE     /var/run/apache2.pid
ENV APACHE_RUN_DIR      /var/run/apache2
ENV APACHE_LOCK_DIR     /var/lock/apache2
ENV APACHE_LOG_DIR      /var/log/apache2

ENV CA_PROVIDENCE_VERSION=1.7.8
ENV CA_PROVIDENCE_DIR=/var/www/providence
ENV CA_PAWTUCKET_VERSION=1.7.8
ENV CA_PAWTUCKET_DIR=/var/www

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install -y apache2 \
					php7.4 \
					libapache2-mod-php \
					curl \
					php7.4-mysql \
					mysql-client \
					curl \
					php7.4-curl \
					php7.4-xml \
                    php7.4-bcmath \ 
					zip \
					wget \
					ffmpeg \
					ghostscript \
					imagemagick \
					php7.4-gd \
					libreoffice \
					php7.4-zip \
					vim

RUN update-alternatives --set php /usr/bin/php7.4
COPY providence $CA_PROVIDENCE_DIR

#GMAGICK
RUN apt-get install -y php-pear php-dev graphicsmagick libgraphicsmagick1-dev php-gmagick
# && pecl install gmagick-2.0.4RC1

# better PDF (wkhtmltopdf)
RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.bionic_arm64.deb && apt install -y ./wkhtmltox_0.12.6-1.bionic_arm64.deb

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
# ignore-platform-recs is a hacky workaround for bagittools requiring the intl ext which wasnt avilable in the ondrej repo
RUN cd $CA_PROVIDENCE_DIR && composer --ignore-platform-reqs install

# RUN curl -SsL https://github.com/collectiveaccess/providence/archive/$CA_PROVIDENCE_VERSION.tar.gz | tar -C /var/www/ -xzf -
# RUN mv /var/www/providence-$CA_PROVIDENCE_VERSION /var/www/providence

RUN curl -SsL https://github.com/collectiveaccess/pawtucket2/archive/$CA_PAWTUCKET_VERSION.tar.gz | tar -C /var/www/ -xzf -
RUN mv $CA_PAWTUCKET_DIR/pawtucket2-$CA_PAWTUCKET_VERSION/* /var/www

RUN sed -i "s@DocumentRoot \/var\/www\/html@DocumentRoot \/var\/www@g" /etc/apache2/sites-available/000-default.conf
RUN rm -rf /var/www/html
run mkdir /$CA_PROVIDENCE_DIR/media/collectiveaccess
RUN ln -s /$CA_PROVIDENCE_DIR/media /$CA_PAWTUCKET_DIR/media


COPY files/php.ini /etc/php/7.2/apache2/php.ini
COPY files/setup-providence.php /$CA_PROVIDENCE_DIR/setup.php
COPY files/app.conf /$CA_PROVIDENCE_DIR/app/conf/app.conf
COPY files/multipart_id_numbering.conf /$CA_PROVIDENCE_DIR/app/conf/multipart_id_numbering.conf
COPY files/setup-pawtucket.php /$CA_PAWTUCKET_DIR/setup.php
COPY files/entrypoint.sh /entrypoint.sh
RUN chown -R www-data:www-data /var/www
RUN chmod g+rwxs -R /var/www/app/tmp
RUN chmod g+rwxs -R /var/www/providence/app/tmp
RUN chmod g+rwxs -R /var/www/providence/import

RUN chmod 777 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD [ "/usr/sbin/apache2", "-DFOREGROUND" ]
