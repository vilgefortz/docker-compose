FROM docker:18.09.2

ARG compose_version=1.22.0

# Install docker-compose (extra complicated since the base image uses alpine as base)
RUN apk update && apk add --no-cache \
    curl openssl ca-certificates 
RUN curl -L https://github.com/docker/compose/releases/download/${compose_version}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose 
RUN chmod +x /usr/local/bin/docker-compose 
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub 
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk 
RUN apk add --no-cache glibc-2.23-r3.apk && rm glibc-2.23-r3.apk 
RUN ln -s /lib/libz.so.1 /usr/glibc-compat/lib/ 
RUN ln -s /lib/libc.musl-x86_64.so.1 /usr/glibc-compat/lib
