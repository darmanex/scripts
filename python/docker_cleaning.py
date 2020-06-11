#!/usr/bin/python3

# Description:
# this script it uses to clean up docker images and containers on Aino servers (dev, staging, sandbox)
# better to execute this script via cronjob

import os

print("Cleaning containers exited status and docker none images are processing..")
os.system('sleep 2')

exited_containers = os.system('docker ps -a -q -f "status=exited"')
none_images = os.system("docker images | grep '^<none>' | awk '{print $3}'")

if exited_containers == True:
    os.system('docker rm' exited_containers)
    print("[+] Cleanup containers that have exited status...")
elif none_images == True:
    os.system('docker rmi' none_images)
    print("[+] Cleanup images that have none status...")
else:
    print("All done. No containers exited and none images on your system!")
