#!/usr/bin/env bash
sudo chown -R $(whoami) /etc/sysctl.conf

echo '=================================== 1 =========================='
sudo cat > /etc/sysctl.conf <<EOF
net.ipv4.ip_forward = 1
EOF
echo '=================================== 2 =========================='
sudo sysctl -p
echo '=================================== 3 =========================='
sudo iptables -t nat -A POSTROUTING -o eth0 -s 172.16.2.0/24 -j MASQUERADE