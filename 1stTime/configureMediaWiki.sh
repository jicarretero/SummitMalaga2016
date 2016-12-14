#!/bin/bash -xe

KEY=../../summitkp

IP=$(nova show krtapache | gawk '/ 130.206./ {print gensub(/.* (130\.206\.[0-9]+\.[0-9]+).*/,"\\1","g",$0)}')
[ ! -z "$IP" ]

sed -i orig 's|^$wgLogo .*=.*|$wgLogo = "/wiki/Logo/logo.jpg";|g' LocalSettings.php | sed 's|^$wgLogo .*=.*|$wgLogo = "/wiki/Logo/logo.jpg";|g' LocalSettings.php

cat << EOT >> LocalSettings.php
wfLoadExtension( 'SyntaxHighlight_GeSHi' );

\$wgPygmentizePath = "/usr/bin/pygmentize";

\$wgFileExtensions[]='pdf';
\$wgFileExtensions = array_merge( \$wgFileExtensions,
     array( 'doc', 'xls', 'mpp', 'ppt', 'xlsx', 'jpg', 'pdf',
    'tiff', 'odt', 'odg', 'ods', 'odp', 'gz', 'bz2', 'zip', 'eml'
  )
                 );
\$wgVerifyMimeType = false;
\$wgStrictFileExtensions = false;
\$wgCheckFileExtensions = false;
\$wgAllowJavaUploads = true;

EOT

scp -i $KEY LocalSettings.php ubuntu@$IP:/tmp
scp -i $KEY logo.jpg ubuntu@$IP:/tmp

ssh -i $KEY ubuntu@$IP "sudo cp /tmp/LocalSettings.php /var/www/html/wiki ; sudo chown www-data.www-data /var/www/html/wiki/LocalSettings.php"
ssh -i $KEY ubuntu@$IP "sudo mkdir /var/www/html/wiki/Logo ; sudo cp /tmp/logo.jpg /var/www/html/wiki/Logo ; sudo chown -R www-data.www-data /var/www/html/wiki/Logo"

