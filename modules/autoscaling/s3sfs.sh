#!/bin/bash
apt-get update
apt-get install apache2 php php-mysql nfs-common s3fs mysql-client -y
service apache2 restart
mkdir -p /var/www/html/wp-content/uploads
echo ${efspoint}':/ /var/www/html nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 0 0' >> /etc/fstab
echo 's3fs#roshanjoseph.ml:/uploads /var/www/html/wp-content/uploads fuse _netdev,allow_other,iam_role,url=http://s3.amazonaws.com 0 0' >> /etc/fstab
service apache2 restart
mount -a

