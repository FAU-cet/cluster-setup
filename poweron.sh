#! /bin/bash

# from outside (uses different script)
if ! host opnsense > /dev/null
then
  ssh faucet ./poweron.sh
  exit
fi

wakeup () {
  wol $1
  echo "Sent signal to $2 ($1)"
  sleep 10 # prevent tripping braker
}

wakeup 90:1b:0e:3d:d3:3d viz
wakeup 10:ff:e0:06:2e:dc drain
wakeup 10:ff:e0:06:2e:d0 hot
wakeup 10:ff:e0:06:2f:22 cold
