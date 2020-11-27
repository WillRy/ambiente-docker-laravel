FROM php:7.3.6-fpm-alpine3.10

RUN apk add --no-cache \
            shadow \
            openssl \
            bash \
            mysql-client \
            nodejs \
            npm \
            freetype-dev \
            libjpeg-turbo-dev \
            libpng-dev \
            $PHPIZE_DEPS

# atualiza timezone do php
RUN pecl install timezonedb
RUN docker-php-ext-enable timezonedb



RUN docker-php-ext-install pdo pdo_mysql bcmath
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

RUN pecl install xdebug \
	&& docker-php-ext-enable xdebug

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /var/www
RUN rm -rf /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN npm config set cache /var/www/.npm-cache --global

RUN ln -s public html

RUN usermod -u 1000 www-data
USER www-data


EXPOSE 9000
ENTRYPOINT ["php-fpm"]
