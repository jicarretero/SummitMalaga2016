#!/bin/bash -xe

token=($(openstack token issue | awk '/ id / || / project_id / {print $4}'))
TOKEN=${token[0]}
TENANT_ID=${token[1]}
MYSQL_IP=$(nova show krtmysql | awk '/node-int-net-01 network/ { print $5}' )
APACHE_IP=$(nova show krtapache | gawk '/ 130.206./ {print gensub(/.* (130\.206\.[0-9]+\.[0-9]+).*/,"\\1","g",$0)}');
URL=http://130.206.112.3:8080/v1
KEY=../../summitkp

ssh -i $KEY ubuntu@$APACHE_IP "cd /tmp ; swift --os-auth-token $TOKEN --os-storage-url=$URL/AUTH_$TENANT_ID download summit wikidb.sql.gz ; gzip -d wikidb.sql.gz"
ssh -i $KEY ubuntu@$APACHE_IP "mysql -u wiki -pwiki -h$MYSQL_IP wiki -e 'source /tmp/wikidb.sql'"
