FROM php:8.5-fpm-trixie

RUN apt-get update && \
    apt-get install -y \
    openssl \
    wget \
    #extensao necessária para o php
    zlib1g-dev \
    #GD
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    #Imagick
    imagemagick \
    libmagickwand-dev \
    #Intl
    libicu-dev \
    #Zip
    libzip-dev \
    unzip \
    # openssl
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev \
    #ssh2
    libssh2-1-dev \
    #limpa apt
    && apt-get clean && rm -rf /var/lib/apt/lists/*


# instalar o PIE que está substituindo o PECL como instalador de extensões PHP
RUN wget -qO /tmp/pie.phar https://github.com/php/pie/releases/latest/download/pie.phar \
    && mv /tmp/pie.phar /usr/local/bin/pie \
    && chmod +x /usr/local/bin/pie

RUN docker-php-ext-install mysqli pdo_mysql bcmath exif gd intl zip sockets pcntl

RUN pecl install https://pecl.php.net/get/ssh2-1.3.1.tgz && docker-php-ext-enable ssh2

RUN pie install xdebug/xdebug
RUN pie install imagick/imagick
RUN pie install phpredis/phpredis
RUN pie install mongodb/mongodb-extension


# atualiza timezone do php
# RUN pecl install timezonedb
# RUN docker-php-ext-enable timezonedb

# configura GD
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd

ENV DOCKERIZE_VERSION=v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 1000 www-data


RUN rm -rf /var/www/html
RUN rm -rf /var/www/public

# entrypoint
RUN mkdir -p /dockerfiles
COPY . /dockerfiles
RUN chmod +x /dockerfiles/entrypoint.sh
ENTRYPOINT [ "/dockerfiles/entrypoint.sh" ]

USER www-data

WORKDIR /var/www

EXPOSE 9000
