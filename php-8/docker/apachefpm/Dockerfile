FROM httpd:2.4.46

RUN apt-get update && \
    apt-get install -y \
    wget

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN mkdir -p /var/www


RUN usermod -u 1000 daemon

# entrypoint
RUN mkdir -p /dockerfiles
COPY . /dockerfiles
RUN chmod +x /dockerfiles/entrypoint.sh
ENTRYPOINT [ "/dockerfiles/entrypoint.sh" ]

WORKDIR /var/www