#!/bin/sh

# export pin 216 and set it initially output high
echo 216 > /sys/class/gpio/export
echo in > /sys/class/gpio/gpio216/direction
echo 0 > /sys/class/gpio/gpio216/value

# set group to gpio (remember to add group gpio to system)
chown root:gpio /sys/class/gpio/gpio216/direction /sys/class/gpio/gpio216/value

# set permissions for later python use (VERY UGLY!)
chmod 777 /sys/class/gpio/export
chmod 777 /sys/class/gpio/unexport
chmod 777 /sys/class/gpio/gpio216/direction 
chmod 777 /sys/class/gpio/gpio216/value 
