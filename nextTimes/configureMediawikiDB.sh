#!/bin/bash -xe

KEY=../../summitkp

FL_IP=$(nova show krtapache | gawk '/ 130.206./ {print gensub(/.* (130\.206\.[0-9]+\.[0-9]+).*/,"\\1","g",$0)}')
MYSQL_IP=$(nova show krtmysql | awk '/node-int-net-01 network/ { print $5}' )

ssh -i $KEY ubuntu@$FL_IP sudo "sed -i 's/^\$wgDBserver.*/\$wgDBserver         = \"$MYSQL_IP\";/g' /var/www/html/wiki/LocalSettings.php"
