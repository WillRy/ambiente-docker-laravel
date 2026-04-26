#!/bin/sh

dockerize -template ./docker/nginx/nginx.conf:/etc/nginx/conf.d/nginx.conf

dockerize ${WAIT} -timeout 90s

nginx -g "daemon off;"
