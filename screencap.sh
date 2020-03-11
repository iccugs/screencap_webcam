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
echo
echo -e "\033[35;1m.▄▄ ·  ▄▄· ▄▄▄  ▄▄▄ .▄▄▄ . ▐ ▄         \033[0m"
echo -e "\033[35;1m▐█ ▀. ▐█ ▌▪▀▄ █·▀▄.▀·▀▄.▀·•█▌▐█        \033[0m"
echo -e "\033[35;1m▄▀▀▀█▄██ ▄▄▐▀▀▄ ▐▀▀▪▄▐▀▀▪▄▐█▐▐▌        \033[0m"
echo -e "\033[35;1m▐█▄▪▐█▐███▌▐█•█▌▐█▄▄▌▐█▄▄▌██▐█▌        \033[0m"
echo -e "\033[35;1m ▀▀▀▀ ·▀▀▀ .▀  ▀ ▀▀▀  ▀▀▀ ▀▀ █▪        \033[0m"
echo -e "\033[35;1m ▄▄·  ▄▄▄·  ▄▄▄·▄▄▄▄▄▄• ▄▌▄▄▄  ▄▄▄ .   \033[0m"
echo -e "\033[35;1m▐█ ▌▪▐█ ▀█ ▐█ ▄█•██  █▪██▌▀▄ █·▀▄.▀·   \033[0m"
echo -e "\033[35;1m██ ▄▄▄█▀▀█  ██▀· ▐█.▪█▌▐█▌▐▀▀▄ ▐▀▀▪▄   \033[0m"
echo -e "\033[35;1m▐███▌▐█ ▪▐▌▐█▪·• ▐█▌·▐█▄█▌▐█•█▌▐█▄▄▌   \033[0m"
echo -e "\033[35;1m·▀▀▀  ▀  ▀ .▀    ▀▀▀  ▀▀▀ .▀  ▀ ▀▀▀    \033[0m"
echo -e "\033[35;1m▄▄▌ ▐ ▄▌▄▄▄ .▄▄▄▄·  ▄▄·  ▄▄▄· • ▌ ▄ ·. \033[0m"
echo -e "\033[35;1m██· █▌▐█▀▄.▀·▐█ ▀█▪▐█ ▌▪▐█ ▀█ ·██ ▐███▪\033[0m"
echo -e "\033[35;1m██▪▐█▐▐▌▐▀▀▪▄▐█▀▀█▄██ ▄▄▄█▀▀█ ▐█ ▌▐▌▐█·\033[0m"
echo -e "\033[35;1m▐█▌██▐█▌▐█▄▄▌██▄▪▐█▐███▌▐█ ▪▐▌██ ██▌▐█▌\033[0m"
echo -e "\033[35;1m ▀▀▀▀ ▀▪ ▀▀▀ ·▀▀▀▀ ·▀▀▀  ▀  ▀ ▀▀  █▪▀▀▀\033[0m"
echo
echo "                   By: Paradox"
echo
read -n 1 -s -r -p "Press any key to continue"
clear
echo
echo
echo "This script relies on v4l2loopback, ffmpeg, mplayer, and make.
Please make sure these dependencies are installed beforehand."
echo
echo "This script has only been tested on Arch Linux with the 4.19
LTS Linux kernel. It may work with other kernels/distributions,
but they have not been tested by me."
echo
echo
read -n 1 -s -r -p "Press any key to continue"
clear
echo
echo
echo "Does v4l2loopback need to be turned on?"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) clear; echo; echo; echo "Video device list before v4l2loopback is enabled:"; ls -ltrh /dev/video*; echo ""; sudo modprobe v4l2loopback; echo ""; echo "Video device list after v4l2loopback was enabled:"; ls -ltrh /dev/video*; break;;
		No ) clear; echo; echo; echo "Video device list:"; ls -ltrh /dev/video*; break;;
	esac
done
echo ""
echo ""
echo "What is the name of the loopback device? ie. /dev/video0, /dev/video1, etc."
read VIDEO_DEV
clear
echo
echo
echo "This script uses a file called /tmp/pipe to pipe the screen capture
and then uses that pipe file to stream to the dummy webcam. Does the
/tmp/pipe file need to be created?"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) mkfifo /tmp/pipe; break;;
		No ) break;;
	esac
done
clear
echo
echo
echo "What is your desktop's resolution? (ie. 1200x720, 1920x1080, etc.)"
read VIDEO_RES
clear
echo
echo
echo "What resolution would you like the capture to be piped at? DO NOT
put the \"p\" at the end!!! (ie. 420 seems to work well for flash,
but feel free to experiment with other resolutions for nonflash)"
read PIPE_RES
clear
echo
echo
echo "What would you like the framerate of the capture to be? (ie. 15
for 15fps, 30 for 30fps, etc.)"
read FPS
clear
echo
echo
echo "Is the dummy webcam being used for a flash website?"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) FLASH=YVU; break;;
		No ) FLASH=YUV; break;;
	esac
done
clear
echo
echo
echo "Does yuv4mpeg_to_v4l2.c need to be made and added to the /bin/
directory? (this has to be redone every time you change the resolution
or flash/no-flash options)"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) sudo rm /bin/yuv4mpeg_to_v4l2; sed -i '171s/.*/\tv.fmt.pix.pixelformat = V4L2_PIX_FMT_'$FLASH''$PIPE_RES';/' yuv4mpeg_to_v4l2.c; make yuv4mpeg_to_v4l2; sudo mv yuv4mpeg_to_v4l2 /bin/; break;;
		No ) break;;
	esac
done
clear
echo
echo
echo "What resolution would you like mplayer to scale the capture to? ie. 320:180 is usually a safe bet."
read SCALE
clear
echo
echo
echo "Remember: To kill the dummy webcam, hold CTRL and tap C a few times to stop the loop"
read -n 1 -s -r -p "Press any key to start the capture..."
while :
do
	yuv4mpeg_to_v4l2 $VIDEO_DEV < /tmp/pipe &
	ffmpeg -f x11grab -r $FPS -s $VIDEO_RES -i :0.0+0,0 -vcodec rawvideo -pix_fmt "yuv"$PIPE_RES"p" -threads 0 -f avi - | mplayer - -vf scale=$SCALE -vo yuv4mpeg:file=/tmp/pipe
done
