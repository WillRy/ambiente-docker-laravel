FROM php:8.1.0-apache-buster

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
    #limpa apt
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mysqli pdo_mysql bcmath exif gd intl zip sockets pcntl
RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN pecl install imagick && docker-php-ext-enable imagick
RUN pecl install redis && docker-php-ext-enable redis
RUN pecl install mongodb && docker-php-ext-enable mongodb

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


RUN a2enmod rewrite && a2enmod proxy && a2dissite 000-default
RUN rm -rf /var/www/html
RUN rm -rf /var/www/public
RUN rm -rf /etc/apache2/sites-enabled/000-default.conf

# entrypoint
RUN mkdir -p /dockerfiles
COPY . /dockerfiles
RUN chmod +x /dockerfiles/entrypoint.sh
ENTRYPOINT [ "/dockerfiles/entrypoint.sh" ]

USER www-data

WORKDIR /var/www

EXPOSE 9000