#!/bin/bash -ex

PUBLIC_EXT_NET=public-ext-net-01
FLAVOR=m1.small
IMAGE=base_ubuntu_14.04
SECGROUP=allopen
KEY=summitkp
NAME=krtapache
URL=http://130.206.112.3:8080/v1
APACHE_CONFIG_FILE=/tmp/apache2.init

source ./configureApacheInitFile

NETUUID=$(openstack network list | awk '/ node-int-net-01 / {print $2}')

VOLUMEID=$(openstack volume list | awk '/apache-vol/ {print $2}')

ID_APACHE=$(nova boot --nic net-id=$NETUUID --image $IMAGE --key-name $KEY --security-groups $SECGROUP --flavor $FLAVOR --block-device-mapping vdb=$VOLUMEID --user-data $APACHE_CONFIG_FILE $NAME | awk '/ id / {print $4}')

FLOATING_IP=$(openstack floating ip list | awk '/ 130\.206\..* / {print $4}')
[ -z "$FLOATING_IP" ] && FLOATING_IP=$(openstack floating ip create $PUBLIC_EXT_NET | awk '/ 130\.206\..* / {print $4}')

nova floating-ip-associate ${ID_APACHE} ${FLOATING_IP}
