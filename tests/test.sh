#!/bin/bash
set -euxo pipefail

# Load kernel modules and stuff
sudo modprobe can
sudo modprobe can_raw
sudo modprobe vcan

# Bring up vcan interface
sudo ip link add dev vcan0 type vcan || true
sudo ip link set up vcan0 || true

# Check to make sure we can see the interface
ip link show vcan0

# Replay data out on vcan0
canplayer -I examples/candump-2019-01-09_224207.log vcan0=slcan0 &

# Decode the data, terminating after we've received all 1588 frames
candump -n 1588 vcan0 | cantools decode --single-line dbc/wavesculptor_20.dbc
