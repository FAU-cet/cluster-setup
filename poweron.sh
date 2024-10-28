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
  sleep ${3:-10} # prevent tripping braker
}

wakeup bc:24:11:ce:e5:73 viz
echo "Press Ctrl+C within the next 10 seconds to stop waking nodes"
wakeup 10:ff:e0:06:2e:dc drain
wakeup 10:ff:e0:06:2e:d0 hot
wakeup 10:ff:e0:06:2f:22 cold 0
