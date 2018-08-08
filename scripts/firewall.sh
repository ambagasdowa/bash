#!/bin/bash

# firts flush the rules of the firewall
 echo "stopping firewall and allowing everyone ... "
 iptables -F
 iptables -X
 iptables -t nat -F
 iptables -t nat -X
 iptables -t mangle -F
 iptables -t mangle -X
 iptables -P INPUT ACCEPT
 iptables -P FORWARD ACCEPT
 iptables -P OUTPUT ACCEPT

#now set the nat 
# this is the ***ing rule for the nat 
# after this build the dhclient server for use the sw
modprobe iptable_nat
# iptables -t nat -A POSTROUTING -s 10.42.23.0/24 -o enp4s0 -j MASQUERADE
# echo 1 > /proc/sys/net/ipv4/ip_forward

#ok now watch this
/etc/init.d/isc-dhcp-server stop
killall dhcpd
sleep 10s

#ifdown enp10s1
ip addr flush enp10s1
ifconfig enp10s1 down

#ip link set wlp3s0 down

#iwconfig wlp3s0 mode Master
#iwconfig wlp3s0 freq 2.422G 
#iwconfig wlp3s0 essid "Ambagasdowa Network"

#iw dev wlp3s0 set type AP 


ip link set up dev enp10s1
sysctl net.ipv4.ip_forward=1
sysctl net.ipv6.conf.default.forwarding=1
sysctl net.ipv6.conf.all.forwarding=1
sleep 2
#another approach 
 #iptables -t nat -A POSTROUTING -o enp0s25 -j MASQUERADE
 #iptables -A FORWARD -i enp0s25 -o wlp3s0 -j ACCEPT
 #iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

ifconfig enp10s1 10.42.44.1/24
iptables -t nat -A POSTROUTING -s 10.42.44.0/24 -o enp4s0 -j MASQUERADE
iptables -A FORWARD -s 10.42.44.0/24 -o enp4s0 -j ACCEPT
iptables -A FORWARD -d 10.42.44.0/24 -m state --state ESTABLISHED,RELATED -i enp4s0 -j ACCEPT

###### route the servers ######

## Corporate Portal
iptables -t nat -A PREROUTING -d 187.141.67.234 -j DNAT --to-destination 192.168.20.100
## database
iptables -t nat -A PREROUTING -d 187.141.67.227 -j DNAT --to-destination 192.168.20.235
##aplications
iptables -t nat -A PREROUTING -d 187.141.67.228 -j DNAT --to-destination 192.168.20.236
##Terminal T1 and T2
iptables -t nat -A PREROUTING -d 187.141.67.229 -j DNAT --to-destination 192.168.20.237
iptables -t nat -A PREROUTING -d 187.141.67.230 -j DNAT --to-destination 192.168.20.238
# tralix
iptables -t nat -A PREROUTING -d 187.141.67.231 -j DNAT --to-destination 192.168.20.239
# IPVX Cisco system
iptables -t nat -A PREROUTING -d 187.141.67.237 -j DNAT --to-destination 192.168.30.4
iptables -t nat -A PREROUTING -d 187.141.67.238 -j DNAT --to-destination 192.168.30.5
## Vigilance Cameras
iptables -t nat -A PREROUTING -d 187.141.67.233 -j DNAT --to-destination 192.168.20.205
## to exchange in teisa ?? 
#iptables -t nat -A PREROUTING -d 192.168.1.91 -j DNAT --to-destination 189.254.105.67


echo 'INTERFACES=enp10s1' > /etc/default/dhcp

dhcpd enp10s1



