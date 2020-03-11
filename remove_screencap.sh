#!/bin/bash
clear
echo
echo
echo -e "\033[5;41;30mThis program requires sudo privileges to run\033[0m"
echo
echo
echo -e "\033[1;31;40mPlease enter password for sudo privileges\033[0m"
echo
echo
sudo echo
clear
echo
echo
echo "This script will attempt to disable the v4l2loopback kernel module
and remove the /tmp/pipe file that was created."
echo
echo "If you are okay with this, press enter to continue."
read -p "Otherwise, press Ctl-C to exit the script."
sudo modprobe -r v4l2loopback
sudo rm /tmp/pipe
clear
echo
echo
echo "[+] v4l2loopback disabled and /tmp/pipe removed."
echo
echo
