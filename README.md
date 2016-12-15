# SummitMalaga2016

This is just a demo for a talk I gave in FIWARE Summit 2016.

The demo for the WIKI is: http://130.206.113.248/wiki/index.php/Main_Page -- I'll let this hosts stay here for a while, but it won't last long.

Before installing anything you must set the openstack variables, or exec your own "keystonerc" file:

    export OS_AUTH_URL=xxx
    export OS_USERNAME=xxx
    export OS_PASSWORD=xxx
    export OS_TENANT_NAME=xxx
    export OS_REGION_NAME=xxx


Please, keep in mind that this demo is not about installing MediaWiki itself but using OpenStack Command Line Interface (CLI) tools. It is about showing some tools which can help developers automate processes and it is about showing OpenStack most important components (except neutron).

# Files
=======
* ``FiwareMalaga.odp`` and ``FiwareMalagaScaled4_3.odp`` is the presentation (formats 16:9 and 4:3)
* ``wiki.sql.gz`` is the database content for the demo. It basically explains the demo.
* ``0rdtime`` is a directory whith a Script which populates the database and a note file named "firstcommands"
* ``1sttime`` is a directory which has the scritps to do a first installation of Mediawiki from Scratch.
  - ``firstInstallApache.sh`` creates a new VM for Apache and injects the InstallApacheThings in the instance it creates (to configure one Apache server)
  - ``firstInstallMysql.sh`` creates a new VM for MySQL and injects the InstallMysqlThings in the instance it creates (to configure Mysql and create a database and a user.
* ``nexttimes`` is a directory which has the scripts to do some next installations of MediaWiki and to reconfigure the Database after a reinstallation of MySQL in another instance (with a different Fixed IP).
  - ``nextInstallApache.sh`` Which does Apache/MediaWiki installation from a preconfigured Mediawiki which the injected script (configureApacheInitFile) downloads from Swift Object Storage
  - ``nextInstallMysql.sh`` which install an MySQL instance from a previously saved Snapshot from the original MySQL database.
  - ``configureMediawikiDB.sh`` is a script to reconfigure database host in the Mediawiki configuration file.

