#!/bin/bash

PATH="$PATH:/usr/sbin"

iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X
iptables -t nat -X
iptables -t mangle -X

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p TCP -s 192.168.77.0/24 --dport 22 -j ACCEPT
iptables -A INPUT -p TCP -s 192.168.15.0/24 --dport 22 -j ACCEPT
iptables -A INPUT -p TCP -s 192.168.0.0/24 --dport 22 -j ACCEPT
iptables -A INPUT -p TCP -s puppet -j ACCEPT
iptables -A INPUT -p TCP -s zabbix.domain.ru --dport 10500 -j ACCEPT
iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited


iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -j REJECT --reject-with icmp-host-prohibited
