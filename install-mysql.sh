#!/bin/bash
DB_PASSWORD=password
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -y
sudo apt-get install -y debconf
sudo debconf-set-selections <<< \
  "mysql-server mysql-server/root_password password $DB_PASSWORD"
sudo debconf-set-selections <<< \
  "mysql-server mysql-server/root_password_again password $DB_PASSWORD"
sudo debconf-set-selections <<< \
  "mysql-server mysql-server/default-auth-override select Use Legacy Authentication Method (Retain MySQL 5.x Compatibility)"

sudo mkdir -p /etc/mysql/conf.d/
echo "[mysql]" | sudo tee /etc/mysql/conf.d/mysql.cnf
sudo dpkg --configure -a

sudo apt-get install mysql-server -y
echo "mysql installed"
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -uroot -p$DB_PASSWORD < ./sql-commands.txt;
sudo systemctl restart mysql
sudo grep -r 'bind-address' /etc/mysql/*
echo "mysql ready for remote connections"
sleep 10s
