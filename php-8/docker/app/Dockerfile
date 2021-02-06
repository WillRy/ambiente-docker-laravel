FROM php:8.0.2-fpm-buster

RUN apt-get update && \
    apt-get install -y \
    openssl \
    wget \
    nodejs \
    npm \
    #extensao necessária para o php
    zlib1g-dev \
    #GD
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    #Intl
    libicu-dev \
    #limpa apt
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install mysqli pdo_mysql bcmath exif gd intl

# RUN touch /home/www-data/.bashrc | echo "PS1='\w\$ '" >> /home/www-data/.bashrc

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# atualiza timezone do php
# RUN pecl install timezonedb
# RUN docker-php-ext-enable timezonedb

# configura GD
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
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