#!/bin/sh
cat > /etc/dnsmasq.conf <<EOF
dhcp-range=interface:eth0,192.168.99.2,192.168.99.10,255.255.255.0,86400s
dhcp-option=interface:eth0,3,192.168.99.1
dhcp-option=interface:eth0,252,"\n"
dhcp-option=interface:eth0,15
dhcp-option=interface:eth0,28
dhcp-option=interface:eth0,60,00:00:01:00:02:03:43:50:45:03:0e:45:38:20:47:50:4f:4e:20:52:4f:55:54:45:52:04:03:31:2E:30
dhcp-option-force=interface:eth0,125,00:00:00:00:1a:02:06:48:47:57:2d:43:54:0a:02:20:00:0b:02:00:55:0d:02:00:2e
EOF
cat > /etc/rc.local <<EOF
ip addr add 192.168.99.1/24 dev eth0
iptables -I INPUT -i eth0 -m state --state NEW -j ACCEPT
iptables -I FORWARD -i eth0 -o pppoe-wan -j ACCEPT
EOF
