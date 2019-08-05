#!/bin/bash
# author: darm
# title: port checker (memeriksa port pada host bca mc2)
# requirements: install netcat terlebih dahulu pada server jika belum ada

# menentukan server, defaultnya set ke localhost
# silakan diubah jika ingin menembak host lain
SERVER=$HOSTNAME
PORTDIR=/var/log/port-checker
CURDATE=$(date)
LOGFILE=$PORTDIR/port-checker.log

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

echo "Checking open port for $SERVER"
echo "Please wait a second ..."
sleep 0

add_log()
{
    mkdir -p $PORTDIR && cd $PORTDIR && touch $LOGFILE
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
    "9160 (Cassandra)"
    "8181 (S3-Cassandra)"
    "9200 (Elasticsearch)"
    "9300 (Elasticsearch)"
    "7199 (JMX)"
    "9042 (CQWL)"
)

IFS=""

for PORT in ${SERVICES[@]};
do
    sleep 1
    nc -z -w5 $SERVER $PORT

    if [ "$?" -eq 0 ]; then
        echo "[✔] Server $SERVER on port $PORT - Open"
    else
        echo "[X] Server $SERVER on port $PORT - Closed"
    fi


done 2>/dev/null

add_log

echo "Last checked at $CURDATE" >> $LOGFILE

echo "Logs saved in $PORTDIR"

echo "Checking port done!"