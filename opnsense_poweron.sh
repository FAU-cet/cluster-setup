#! /bin/sh

# no bash in BSD :(

# echo viz:
# wol -i 10.0.1.255 bc:24:11:ce:e5:73
# echo "Woke viz, press Ctrl+C within the next 10 seconds to stop waking nodes"
# sleep 10

echo drain:
wol -i 10.0.1.255 10:ff:e0:06:2e:dc
sleep 10

echo hot:
wol -i 10.0.1.255 10:ff:e0:06:2e:d0
sleep 10

echo cold:
wol -i 10.0.1.255 10:ff:e0:06:2f:22
