#!/bin/bash
# author: darm
# title: port checker (memeriksa port pada host bca mc2)
# requirements: install netcat terlebih dahulu pada server jika belum ada

# menentukan server, defaultnya set ke localhost
# silakan diubah jika ingin menembak host lain
SERVER=$HOSTNAME
LOGDIR=/var/log/port-checker
CURDATE=$(date)
LOGFILE=$LOGDIR/port-checker.log

# cek hak akses
if [[ $EUID -ne 0 ]]; then
   echo "WARNING!!! This script must be run as root!" 
   exit 1
fi

# cek sistem
host=$(uname | tr 'A-Z' 'a-z')
if [ $host = "darwin" ] || [ $host = "linux" ]; then
	clear
    echo "Machine: $host"
else
	echo "Sorry, only support for Mac OS X and Linux."
	exit 1
fi

clear
echo "Checking open port for $SERVER"
echo "Please wait a second ..."
sleep 0

add_log()
{
    mkdir -p $LOGDIR && cd $LOGDIR && touch $LOGFILE
}

# list port yang akan di cek
declare -a SERVICES=(
    "80 (http)"
    "443 (https)"
    "4150 (nsqd)"
    "4151 (nsqd)"
    "4160 (nsqlookupd)"
    "4161 (nsqlookupd)"
    "4171 (nsqadmin)"
    "5577 (messaging)"
    "5588 (messaging)"
    "9160 (cassandra)"
    "8181 (s3-Cassandra)"
    "9200 (elasticsearch)"
    "9300 (elasticsearch)"
    "7199 (JMX)"
    "9042 (CQL)"
)

IFS=""

for PORT in ${SERVICES[@]};
do
    sleep 1
    nc -z -w5 $SERVER $PORT

    if [ "$?" -eq 0 ]; then
        echo "[✔] Server $SERVER on port $PORT - Open" 2>&1 | tee -a $LOGFILE
    else
        echo "[X] Server $SERVER on port $PORT - Closed" 2>&1 | tee -a $LOGFILE
    fi

done 2>/dev/null

add_log

echo "Last checked at $CURDATE" >> $LOGFILE

echo "Logs saved in $LOGDIR"

echo "Checking port done!"