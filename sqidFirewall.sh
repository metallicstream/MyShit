#!/bin/sh
# ------------------------------------------------------------------------------------
# See URL: http://www.cyberciti.biz/tips/linux-setup-transparent-proxy-squid-howto.html
# (c) 2006, nixCraft under GNU/GPL v2.0+

# -------------------------------------------------------------------------------------

# squid server IP
SQUID_SERVER="10.42.0.1"
# Interface connected to Internet
INTERNET="enp6s0"
# Interface connected to LAN
LAN_IN="enp4s0f1"
# Squid port
SQUID_PORT="3128"
#otherInternet
OTHINTERNET="enp4s0f1"
#AP host
APLAN="wlp7s0"

#---------------------------------------------------------------------------------------------

#backup present IP tables
iptables-save | sudo tee /home/metallicstream/old.firewall.rules
chown metallicstream:root /home/metallicstream/old.firewall.rules
chmod 775 /home/metallicstream/old.firewall.rules

#----------------------------------------------------------------------------------------------

# DO NOT MODIFY BELOW
# Clean old firewall
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

#------------------------------------------------------------------------------------------------

# Load IPTABLES modules for NAT and IP conntrack support
modprobe ip_conntrack
modprobe ip_conntrack_ftp

# For win xp ftp client
#modprobe ip_nat_ftp
echo 1 > /proc/sys/net/ipv4/ip_forward

# Setting default filter policy
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT

# Unlimited access to loop back
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow UDP, DNS and Passive FTP
iptables -A INPUT -i $INTERNET -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow UDP, DNS and Passive FTP
iptables -A INPUT -i $OTHINTERNET -m state --state ESTABLISHED,RELATED -j ACCEPT

# set this system as a router for Rest of LAN
iptables --table nat --append POSTROUTING --out-interface $INTERNET -j MASQUERADE
iptables --append FORWARD --in-interface $LAN_IN -j ACCEPT

# set this system as a router for Rest of APLAN
iptables --table nat --append POSTROUTING --out-interface $INTERNET -j MASQUERADE
iptables --append FORWARD --in-interface $APLAN -j ACCEPT

#------------------------------------------------------------------------------------------------------

# unlimited access to LAN
iptables -A INPUT -i $LAN_IN -j ACCEPT
iptables -A OUTPUT -o $LAN_IN -j ACCEPT

# unlimited access to APLAN
iptables -A INPUT -i $APLAN -j ACCEPT
iptables -A OUTPUT -o $APLAN -j ACCEPT

#--------------------------------------------------------------------------------------------------------
				#open ports to first network
# DNAT port 80 request comming from LAN systems to squid 3128 ($SQUID_PORT) aka transparent proxy
iptables -t nat -A PREROUTING -i $LAN_IN -p tcp --dport 80 -j DNAT --to $SQUID_SERVER:$SQUID_PORT

# if it is same system
iptables -t nat -A PREROUTING -i $INTERNET -p tcp --dport 80 -j REDIRECT --to-port $SQUID_PORT

# DNAT port 443 request comming from LAN systems to squid 3128 ($SQUID_PORT) aka transparent proxy
iptables -t nat -A PREROUTING -i $LAN_IN -p tcp --dport 443 -j DNAT --to $SQUID_SERVER:$SQUID_PORT

# if it is same system
iptables -t nat -A PREROUTING -i $INTERNET -p tcp --dport 443 -j REDIRECT --to-port $SQUID_PORT

# DNAT port 10000 request comming from LAN systems to squid 3128 ($SQUID_PORT) aka transparent proxy
iptables -t nat -A PREROUTING -i $LAN_IN -p tcp --dport 10000 -j DNAT --to $SQUID_SERVER:$SQUID_PORT

# if it is same system
iptables -t nat -A PREROUTING -i $INTERNET -p tcp --dport 10000 -j REDIRECT --to-port $SQUID_PORT

#--------------------------------------------------------------------------------------------------------
				#open ports to secend network
# DNAT port 80 request comming from LAN systems to squid 3128 ($SQUID_PORT) aka transparent proxy
iptables -t nat -A PREROUTING -i $APLAN -p tcp --dport 80 -j DNAT --to $SQUID_SERVER:$SQUID_PORT

# if it is same system
iptables -t nat -A PREROUTING -i $OTHERINTERNET -p tcp --dport 80 -j REDIRECT --to-port $SQUID_PORT

# DNAT port 443 request comming from LAN systems to squid 3128 ($SQUID_PORT) aka transparent proxy
iptables -t nat -A PREROUTING -i $APLAN -p tcp --dport 443 -j DNAT --to $SQUID_SERVER:$SQUID_PORT

# if it is same system
iptables -t nat -A PREROUTING -i $OTHERINTERNET -p tcp --dport 443 -j REDIRECT --to-port $SQUID_PORT

# DNAT port 10000 request comming from LAN systems to squid 3128 ($SQUID_PORT) aka transparent proxy
iptables -t nat -A PREROUTING -i $APLAN -p tcp --dport 10000 -j DNAT --to $SQUID_SERVER:$SQUID_PORT

# if it is same system
iptables -t nat -A PREROUTING -i $OTHERINTERNET -p tcp --dport 10000 -j REDIRECT --to-port $SQUID_PORT

#----------------------------------------------------------------------------------------------------------

# DROP everything and Log it
iptables -A INPUT -j LOG
iptables -A INPUT -j DROP

#----------------------------------------------------------------------------------------------------------

#saving new ip tables for backup
#backup new IP tables
iptables-save | sudo tee /home/metallicstream/present.firewall.rules
chown metallicstream:root /home/metallicstream/present.firewall.rules
chmod 775 /home/metallicstream/present.firewall.rules
