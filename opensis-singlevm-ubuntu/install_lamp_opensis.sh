#!/bin/bash
apt-get -y update

# set up a silent install of MySQL
dbpass=$1

export DEBIAN_FRONTEND=noninteractive
echo mysql-server-5.6 mysql-server/root_password password $dbpass | debconf-set-selections
echo mysql-server-5.6 mysql-server/root_password_again password $dbpass | debconf-set-selections

# install the LAMP stack
apt-get -y install apache2 mysql-server php5 php5-mysql  

# install OpenSIS
cd /var/www/html
wget http://sourceforge.net/projects/opensis-ce/files/opensis6.4.zip/download -O opensis.zip
apt-get install unzip
unzip opensis.zip

# make the opensis directory writable
chown -R www-data opensis
chmod -R 770 opensis

# restart Apache
apachectl restart
