#!/usr/bin/env bash
#
# this script will be automaticaly uploaded and executed by ansible
# to the host server
#

echo "Backing up MC2 WEB started. Please wait a minute..."
RESULT=$?
BACKUPTIME=`date +%Y-%m-%d`

cd /home/digaku

MC2_WEB=mc2-web-standalone-*
DST=backup_mc2_web/MC2-WEB_$BACKUPTIME.tar.gz
SRC=$MC2_WEB
tar -cPzf $DST $SRC

if [ $RESULT -eq 0 ]; then
  echo "Backup $MC2_WEB success!"
else
  echo "Backup $MC2_WEB failed!"
fi
