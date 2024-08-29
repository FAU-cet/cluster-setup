#! /bin/sh

# no bash in BSD :(

echo viz:
wol -i 192.1.1.255 90:1b:0e:3d:d3:3d
echo "Woke viz, press Ctrl+C within the next 10 seconds to stop waking nodes"
sleep 10

echo drain:
wol -i 192.1.1.255 10:ff:e0:06:2e:dc
sleep 10

echo hot:
wol -i 192.1.1.255 10:ff:e0:06:2e:d0
sleep 10

echo cold:
wol -i 192.1.1.255 10:ff:e0:06:2f:22
