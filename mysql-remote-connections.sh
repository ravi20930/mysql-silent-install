#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -uroot -p < ./sql-commands.txt;