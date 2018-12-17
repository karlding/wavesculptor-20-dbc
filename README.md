# Tritium WaveSculptor 20 CAN DBC

[![Build Status](https://travis-ci.org/karlding/wavesculptor-20-dbc.svg?branch=master)](https://travis-ci.org/karlding/wavesculptor-20-dbc)

A CAN DBC file for the Tritium WaveSculptor 20 motor controller.

**Note**: This assumes that your motor controller has a base address of 
`0x80` (the Device Identifier `0x4` shifted left by `5`). If this is not the
case, just edit the addresses to match your configuration.
[Kvaser Database Editor](https://www.kvaser.com/downloads-kvaser/) is a pretty
good option for a free DBC GUI editor.

The CAN Frame ID format (using 11-bit CAN IDs) is as follows:

```
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| x | x | x | x | x | d | d | d | d | d | d | m | m | m | m | m |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
 0xf 0xe 0xd 0xc 0xb 0xa 0x9 0x8 0x7 0x6 0x5 0x4 0x3 0x2 0x1 0x0

m = Message ID
d = Device ID
x = unused
```

## Requirements

These instructions use [eerimoq/cantools](https://github.com/eerimoq/cantools)
over SocketCAN to decode messages with the DBC. If you're using PCAN-Explorer
or something similar, feel free to ignore those steps/requirements and
directly import the DBC.

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

# Decode CAN messages with the DBC
candump slcan0 | cantools decode --single-line dbc/wavesculptor_20.dbc
```
