#!/bin/bash
apt-get update
apt-get install apache2 php php-mysql nfs-common mysql-client -y
service apache2 restart
echo ${efspoint}':/ /var/www/html nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 0 0' >> /etc/fstab
a2enmod rewrite
echo -e '<Directory /var/www/>\nOptions Indexes FollowSymLinks\nAllowOverride All\nOrder allow,deny\nallow from all\n</Directory>' >> /etc/apache2/apache2.conf
service apache2 restart
mount -a
