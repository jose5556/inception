#!/bin/bash
set -e #exit if something fails

mysqld --skip-networking --socket=/var/run/mysqld/mysqld.sock &

sleep 10 #makes sure the database is iniciated

mysql <<-EOSQL  #heredoc
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL

mysqladmin shutdown

exec mysqld
