#!/bin/bash

confd -onetime -backend env

echo "" > /etc/exports

if [ -z ${EXPORTS+x} ]; then
  echo "Setting default value for exports";
  EXPORTS="/exports *(rw,async,no_root_squash,no_subtree_check)"
fi

IFS=";"
for line in $EXPORTS; do
  echo $line >> /etc/exports
done
cat /etc/exports

supervisord -c /etc/supervisor/conf.d/supervisord.conf
