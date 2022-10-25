#!/bin/bash
sudo apt-get -y purge mysql*
sudo apt-get -y purge mysql-server*
sudo apt-get -y remove --purge mysql-server
sudo apt autoremove -y
sudo rm -r /etc/mysql /var/lib/mysql
sudo rm -r /var/log/mysql
sudo apt autoclean -y
sudo apt remove dbconfig-mysql -y
sudo apt-get -y update
sudo apt-get -y dist-upgrade
exit