#!/bin/bash

echo "" > /etc/exports

if [ -z ${EXPORTS+x} ]; then
  echo "Setting default value for exports";
  EXPORTS="/exports *(rw,sync,no_subtree_check,fsid=0,no_root_squash)"
fi

IFS=";"
for line in $EXPORTS; do
  echo $line >> /etc/exports
done
cat /etc/exports

rpcbind
service nfs-kernel-server start

/init
