FROM openresty/openresty:1.13.6.2-2-alpine 

MAINTAINER yuki.iwamoto

USER root
WORKDIR /data

RUN mkdir -p /data/db
COPY ./conf/conf.d /etc/nginx/conf.d
COPY ./conf/lua /etc/nginx/lua

RUN apk add git sqlite sqlite-dev
RUN cd /usr/local/openresty/lualib && \
 git clone https://github.com/stepelu/lua-xsys.git && mv lua-xsys xsys && \
 git clone https://github.com/stepelu/lua-ljsqlite3.git && mv lua-ljsqlite3 ljsqlite3

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]


