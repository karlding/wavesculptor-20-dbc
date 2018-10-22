# Tritium WaveSculptor 20 CAN DBC

A CAN DBC file for the Tritium WaveSculptor 20 motor controller.

*Note*: This assumes that your motor controller has a base address of `0x400`.
If this is not the case, just edit the addresses to match. I recommend using
[SavvyCAN](https://github.com/collin80/SavvyCAN).

[ ] Figure out why SavvyCAN doesn't seem to generate DBCs compatible with cantools

## Requirements

These instructions use [eerimoq/cantools](https://github.com/eerimoq/cantools)
to decode messages using the DBC. If you're using PCAN-Explorer or something
similar, feel free to ignore those steps/requirements and directly import the
DBC.

```
# Ensure that can-utils is installed
sudo apt-get update
sudo apt-get install can-utils

# Start the slcand userspace daemon and create slcan0 interface
# We assume 500 kbps bitrate, see (https://elinux.org/Bringing_CAN_interface_up)
sudo slcand -o -c -s6 /dev/ttyUSB0 slcan0

# Bring up the SocketCAN interface
sudo ifconfig slcan0 up

# Install cantools (either in a virtualenv or something).
pip install cantools
```

## Usage

```
# View the DBC file
cantools dump dbc/wavesculptor_20.dbc

# Decode Tritium messages using the DBC
candump slcan0 | cantools decode --single-line dbc/wavesculptor_20.dbc
```
