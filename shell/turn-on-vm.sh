#!/bin/sh

echo Virtual machine MC2 Dev is starting...

VBoxManage startvm "MC2-WEB-Online-02" --type headless
echo MC2-WEB02 started!

sleep 20
printf "\n\nList of all the VMs are running\n------------------------------\n"
vboxmanage list runningvms
