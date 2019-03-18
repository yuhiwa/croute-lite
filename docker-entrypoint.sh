#!/bin/sh

if [ ! -e /data/db/proxy.db ]; then
    echo ".open /data/db/proxy.db" | sqlite3
    sqlite3 /data/db/proxy.db "CREATE TABLE 'proxy_tbl' ('domain' varchar(255) primary key, 'container' varchar(255));"
    sqlite3 /data/db/proxy.db "CREATE INDEX 'proxy_tbl_index' ON 'proxy_tbl' ('domain', 'container');"
    chown nobody:nobody /data/db/proxy.db
    chmod 777 /data/db
fi
/usr/local/openresty/bin/openresty -g "daemon off;"
