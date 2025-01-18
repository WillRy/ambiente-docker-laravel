#!/bin/bash

dockerize -wait tcp://db:3306 -timeout 90s



if [ ! -f ".env" ]; then
  cp .env.example .env
fi


composer install
php artisan key:generate
php artisan migrate

docker-php-entrypoint

apache2-foreground
