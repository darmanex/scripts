#!/bin/bash
# author: darm
# title: port checker (memeriksa port pada host bca mc2)
# requirement: install netcat terlebih dahulu pada server jika belum ada

# menentukan server, defaultnya set ke localhost
# silakan diubah jika ingin menembak host lain
SERVER=$HOSTNAME

clear
echo "Checking open port for $SERVER ..."
sleep 0

# deklarasi list port yang akan di cek
declare -a SERVICES=(
    "4151 (nsqd)"
    "4160 (nsqlookupd)"
    "4161 (nsqlookupd)"
    "4171 (nsqadmin)"
    "5577 (messaging)"
    "5588 (messaging)"
)

IFS=""

for PORT in ${SERVICES[@]};
do
    sleep 1
    nc -z -w5 $SERVER $PORT
    
    if [ "$?" -eq 0 ]; then
        echo "[+] Server $SERVER on port $PORT - Open"
    else
        echo "[-] Server $SERVER on port $PORT - Closed"
    fi
    
done 2>/dev/null

echo "Checking port done!"