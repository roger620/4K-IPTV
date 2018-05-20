#!/bin/sh
cat > /etc/dnsmasq.conf <<EOF
# Two SRV records for LDAP, each with different priorities
#srv-host=_ldap._tcp.example.com,ldapserver.example.com,389,1
#srv-host=_ldap._tcp.example.com,ldapserver.example.com,389,2

# A SRV record indicating that there is no LDAP server for the domain
# example.com
#srv-host=_ldap._tcp.example.com

# The following line shows how to make dnsmasq serve an arbitrary PTR
# record. This is useful for DNS-SD.
# The fields are <name>,<target>
#ptr-record=_http._tcp.dns-sd-services,"New Employee Page._http._tcp.dns-sd-services"

# Change the following lines to enable dnsmasq to serve TXT records.
# These are used for things like SPF and zeroconf.
# The fields are <name>,<text>,<text>...

#Example SPF.
#txt-record=example.com,"v=spf1 a -all"

#Example zeroconf
#txt-record=_http._tcp.example.com,name=value,paper=A4

# Provide an alias for a "local" DNS name. Note that this _only_ works
# for targets which are names from DHCP or /etc/hosts. Give host
# "bert" another name, bertrand
# The fields are <cname>,<target>
#cname=bertand,bert
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
exit 0
EOF
