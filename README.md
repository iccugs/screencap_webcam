Screen Capture Webcam for Arch Linux 4.19 LTS kernel
By: Paradox
________________________________

Everything pretty much comes ready to go out of the box and is relatively straightforward.  You just need to make sure v4l2loopback, ffmpeg, mplayer, and make are all installed and obviously make sure you "chmod a+x screencap.sh remove_screencap.sh" before you try to run it for the first time.  Other than that, just cd into the script directory and type "./screencap.sh" into the terminal and "./remove_screencap.sh" when you're done using the script.

The yuv4mpeg_to_v4l2.c.bak file is there just in case you mess up the yuv4mpeg_to_v4l2.c file by accident and you need the original.

Also, credit to Eric C. Cooper <ecc@cmu.edu> for making yuv4mpeg_to_v4l2.  Go to https://github.com/umlaeute/v4l2loopback/tree/master/examples for the original source code.  I modified it so it will work with flash properly.
________________________________


In my experience, the best default settings are:

/dev/video0 - if you don't have a webcam plugged in at all

0,0 - if you want to begin the capture at the upper-left corner of the screen

1200x720 - if you are running a screen that is at 720p

420 - for the piped resolution seems to work well in flash

15fps - seems to work alright, but feel free to crank that up if your computer can handle it.
________________________________

Keep in mind every time you restart your computer, the v4l2loopback module needs to be started up again, and /tmp/pipe has to be created again.

Other than that, mess around with the settings until it looks like what you want it to.
Have fun!!! :D