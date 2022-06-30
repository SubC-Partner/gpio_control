# gpio\_control: a ROS package for reading/writing GPIO states on the Pi, Jetson, and many more

## Mapping for Jetson TX2i on Spacely Carrier
Part Number	Board   Name	Pin # (source)*	Carrier Designator
ASG006	    Spacely	P00     (TCA9539@77)

Pin # (source)*	    Carrier Designator (Header-Pin#)	Voltage Level	sysfs #	    In/out (default)	PU/PD (ohms)	
P00 (TCA9539@77)	P13-15	                            3.3	            216	        in	                None
P01 (TCA9539@77)	P13-16	                            3.3	            217	        in	                None
P02 (TCA9539@77)	P13-13	                            3.3	            218	        in	                None
P03 (TCA9539@77)	P13-14	                            3.3	            219	        in	                None
P04 (TCA9539@77)	P13-11	                            3.3	            220	        in	                None
P05 (TCA9539@77)	P13-12	                            3.3	            221	        in		            None
P06 (TCA9539@77)	P13-9	                            3.3	            222	        in	                None
P07 (TCA9539@77)	P13-10	                            3.3	            223	        in		            None
P10 (TCA9539@77)	P13-7	                            3.3	            224	        in		            None
P11 (TCA9539@77)	P13-8	                            3.3	            225	        in		            None
P12 (TCA9539@77)	P13-5	                            3.3	            226	        in		            None
P13 (TCA9539@77)	P13-6	                            3.3	            227	        in		            None
P14 (TCA9539@77)	P13-3	                            3.3	            228	        in		            None
P15 (TCA9539@77)	P13-4	                            3.3	            229	        in		            None
P16 (TCA9539@77)	P13-1	                            3.3	            230	        in		            None
P17 (TCA9539@77)	P13-2	                            3.3	            231	        in		            None

## Overview
Devices such as the Raspberry Pi, NVidia Jetson, BeagleBone Black, etc have GPIO pins as an additional set of IO,
which can be toggled between high/low states or configured to read high/low inputs. This package allows for
ROS control of these pins, allowing for configuring each pin as desired and then reading/writing
them as a ROS node. Additionally, an API which is consistent from device to device is provided,
which aims to make porting robots from platfrom to platform much easier.

This package has been most thoroughly tested on ROS Melodic running on the NVidia Jetson Nano B01
and on ROS Kinetic running on the Raspberry Pi 3 B+, but has been designed with other platforms and
ROS versions in mind. Please file an issue if this package does not behave as expected. Bug fixes 
and contributions, especially ones which support new devices, are welcomed.

The `gpio_control_node` node allows for control of the GPIO of generic Linux systems. This is done
through the standard Linux /dev/sys/gpio filesystem, and therefore allows for support of all
Linux devices with GPIO pins which conform to this standard. This can be specified using the
`--device generic` flag.

Additionally, devices such as the Raspberry Pi, which have their own GPIO software API, are
supported via this API in the same node. `gpio_control_utils.py` provides the backbone for this
node, and can also be imported to provide standardized GPIO control across the variety of
machines this package supports. See the section on 'gpio_control_utils' for more information.

NOTE: Writing GPIO control states via the filesystem may include writing to pins which are in use
by the operating system, which can have unexpected consequences (loss of SD card data, crashes, etc).
It is recommended that you use the device-specific flag, which will perform safety checks and prevent
you from doing anything too damaging. There are device specific flags for the Raspberry Pi's (`--device pi`),
Nvidia Jetson's (`--device jetson`), BeagleBone Black (`--device beaglebone-experimental`),
and Onion Omega (`--device onion-experimental`).

The final device flag is in the form of `--device simulated`. This flag prevents any actual hardware
manipulation, which makes it useful for running nodes in simulation. 

Python dependencies should already be installed if you are using a device-specific API on its
official operating system. If they are not installed properly, the node will notice and provide
some next steps for you to take.

## Usage
Each node accepts the same command line parameters. In the following command, `gpio_control` is used
to create an input on pin 12 of the Raspberry Pi:

```
rosrun gpio_control gpio_control --device pi --input 12
```

Upon running this command, there should now be a topic titled `/gpio_outputs/twelve` which
is publishing a `gpio_control/InputState` message.

Creating an output is similar:
```
rosrun gpio_control gpio_control --device pi --output 12
```

Upon running this command, there should now be a topic titled `/gpio_outputs/twelve`
which will publish a `gpio_control/OutputState` upon a state change. The rate at which
the node will check for a state change can be specified using `--rate`. Alternatively,
the current state of a pin can be published continuously at the rate using `--constant-publish`.

It is possible to control multiple multiple pins with one node:
```
rosrun gpio_control gpio_control_node --device generic --output 12 13 14 --input 15 16 17
```

It is also possible to make a pin both an input and an output, depending on the device-specific
implementation. This may be useful for error checking.

## gpio_control_utils.py
The `gpio_control_node` operates by providing a command line interface to the `gpio_control_utils`
python package, which will be importable in other projects upon installation. This provides a
standard and stable interface for reading and writing to GPIO pins. See the node for example
usage.
