#!/bin/bash

echo "Backing up Digaku Restapi is started. Please wait a minute..."
RESULT=$?
BACKUPTIME=`date +%Y-%m-%d`

cd /home/digaku

DIGAKU_RESTAPI=mc2-restapi-*
DST=backup_mc2_restapi/MC2-restapi_$BACKUPTIME.tar.gz
SRC=$DIGAKU_RESTAPI
tar -cPzf $DST $SRC

if [ $RESULT -eq 0 ]; then
    echo "Backup $DIGAKU_RESTAPI success!"
else
    echo "Backup $DIGAKU_RESTAPI failed!"
fi
