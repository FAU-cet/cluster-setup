#! /bin/bash

send_command() {
  ssh root@$1 poweroff
  echo "Powered off $1"
}

send_command drain &
send_command hot &
send_command cold &
# send_command viz &
wait
