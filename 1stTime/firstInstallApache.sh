#!/bin/bash -ex

PUBLIC_EXT_NET=public-ext-net-01
FLAVOR=m1.small
IMAGE=base_ubuntu_14.04
SECGROUP=allopen
KEY=summitkp
NAME=krtapache

NETUUID=$(openstack network list | awk '/ node-int-net-01 / {print $2}')

VOLUMEID=$(openstack volume list | awk '/apache-vol/ {print $2}')
[ -z "$VOLUMEID" ] && VOLUMEID=$(openstack volume create --size 1 apache-vol | awk '/ id / {print $4}')

ID_APACHE=$(nova boot --nic net-id=$NETUUID --image $IMAGE --key-name $KEY --security-groups $SECGROUP --flavor $FLAVOR --block-device-mapping vdb=$VOLUMEID --user-data InstallApacheThings0 $NAME | awk '/ id / {print $4}')

FLOATING_IP=$(openstack floating ip list | awk '/ 130\.206\..* / {print $4}')
[ -z "$FLOATING_IP" ] && FLOATING_IP=$(openstack floating ip create $PUBLIC_EXT_NET | awk '/ 130\.206\..* / {print $4}')

nova floating-ip-associate ${ID_APACHE} ${FLOATING_IP}

echo $ID_APACHE
