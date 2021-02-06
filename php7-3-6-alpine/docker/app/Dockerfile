FROM php:7.3.6-fpm-alpine3.10

RUN apk add --no-cache \
    #shadow->usermod
    shadow \
    openssl \
    bash \
    mysql-client \
    nodejs \
    npm \
    #GD
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    #imagick
    imagemagick-dev \
    #intl
    icu-dev \
    $PHPIZE_DEPS
RUN docker-php-ext-install mysqli pdo_mysql bcmath exif gd intl

RUN touch /home/www-data/.bashrc | echo "PS1='\w\$ '" >> /home/www-data/.bashrc

RUN pecl install xdebug imagick \
    && docker-php-ext-enable xdebug imagick

# atualiza timezone do php
RUN pecl install timezonedb
RUN docker-php-ext-enable timezonedb

# configura GD
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 1000 www-data

WORKDIR /var/www

RUN rm -rf /var/www/html && ln -s public html

USER www-data

EXPOSE 9000