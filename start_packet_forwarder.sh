#!/bin/bash

WAIT_GPIO() {
    sleep 0.1
}

pkill lora_pkt_fwd;

if [ -d /sys/class/gpio/gpio$1 ]
then
    echo "$1" > /sys/class/gpio/unexport; WAIT_GPIO
fi

echo "$1" > /sys/class/gpio/export; WAIT_GPIO
echo "out" > /sys/class/gpio/gpio$1/direction; WAIT_GPIO
echo "1" > /sys/class/gpio/gpio$1/value; WAIT_GPIO
echo "0" > /sys/class/gpio/gpio$1/value; WAIT_GPIO
echo "in" > /sys/class/gpio/gpio$1/direction; WAIT_GPIO

$(dirname "$0")/lora_pkt_fwd;