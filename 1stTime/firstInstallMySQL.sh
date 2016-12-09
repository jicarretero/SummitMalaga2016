#!/bin/bash -ex

FLAVOR=m1.small
IMAGE=base_ubuntu_14.04
SECGROUP=allopen
KEY=summitkp
NAME=krtmysql

NETUUID=$(openstack network list | awk '/ node-int-net-01 / {print $2}')

VOLUMEID=$(openstack volume list | awk '/kmysql-vol/ {print $2}')
[ -z "$VOLUMEID" ] && VOLUMEID=$(openstack volume create --size 1 kmysql-vol | awk '/ id / {print $4}')

ID_MYSQL=$(nova boot --nic net-id=$NETUUID --image $IMAGE --key-name $KEY --security-groups $SECGROUP --flavor $FLAVOR --block-device-mapping vdb=$VOLUMEID --user-data InstallMysqlThings $NAME | awk '/ id / {print $4}')

echo $ID_MYSQL
