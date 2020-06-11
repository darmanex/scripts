#!/usr/bin/python3

# Description:
# this script it uses to clean up docker images and containers on Aino servers (dev, staging, sandbox)
# better to execute this script via cronjob

import subprocess
import time

print("Cleaning containers exited status and docker none images are processing..")
time.sleep(1)

exited_containers = subprocess.run('docker ps -a -q -f "status=exited"', shell=True)
none_images = subprocess.run("docker images | grep '^<none>' | awk '{print $3}'", shell=True)

if exited_containers == True:
    subprocess.run('docker rm', exited_containers)
    print("[+] Cleanup containers that have exited status...")
elif none_images == True:
    subprocess.run('docker rmi', none_images)
    print("[+] Cleanup images that have none status...")
else:
    print("You're system is clean. No containers exited and none images that must clean on your system!")
