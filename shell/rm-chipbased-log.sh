#!/bin/bash
# author: darm
# Descripton: this script is use to removing chipbased log uploaded by android device
# Cronjob: this script will execute on every 14th day of month, add this cronjob below
# 0 12 */14 * * $HOME/script/rm-chipbased-log.sh

CUR_DATE=$(date)
LOG_DIR=/root/logger
LOG_FILE=$LOG_DIR/chipbase-remove.log
TARGET_DIR=/home/vsftpd/chip_based_log
TARGET_EXTENSION="*.zip"

find $TARGET_DIR -type f -name $TARGET_EXTENSION -delete

echo "Last removed at $CUR_DATE on $TARGET_DIR" >> $LOG_FILE
