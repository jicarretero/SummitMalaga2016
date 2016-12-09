#!/bin/bash -ex

FLAVOR=m1.small
IMAGE=krtmysql-snp
SECGROUP=allopen
KEY=summitkp
NAME=krtmysql

NETUUID=$(openstack network list | awk '/ node-int-net-01 / {print $2}')

# This time, the volume exists!!!
VOLUMEID=$(openstack volume list | awk '/kmysql-vol/ {print $2}')

nova boot --nic net-id=$NETUUID --image $IMAGE --key-name $KEY --security-groups $SECGROUP --flavor $FLAVOR --block-device-mapping vdb=$VOLUMEID $NAME
