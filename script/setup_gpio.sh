#!/bin/sh

# export pin 230 and set it initially output high
echo 230 > /sys/class/gpio/export
echo out > /sys/class/gpio/230/direction
echo 0 > /sys/class/gpio/230/value

# set group to gpio (remember to add group gpio to system)
chown root:gpio /sys/class/gpio/230/direction /sys/class/gpio/230/value

# set permissions for later python use (VERY UGLY!)
chmod 777 /sys/class/gpio/export
chmod 777 /sys/class/gpio/unexport
chmod 777 /sys/class/gpio/230/direction /sys/class/gpio/230/value 
