 #!/bin/sh
 # Turn a system with profile 'Minimal' into a gateway/firewall. 
 #
 sed -i 's/auto eth0/auto eth0 eth1/' /etc/network/interfaces
 sed -i '/eth1/ s/dhcp/static/' /etc/network/interfaces
 sed -i '/post-up/d' /etc/network/interfaces
 echo 'address 10.0.0.1' >> /etc/network/interfaces
 echo 'dns-nameservers 10.0.2.2' >> /etc/network/interfaces
 echo 'dns-domain intern' >> /etc/network/interfaces
 hostname -b gateway
 hostname > /etc/hostname
 rm -f /etc/dhcp/dhclient-exit-hooks.d/hostname
 rm -f /etc/dhcp/dhclient-exit-hooks.d/wpad-proxy-update
 rm -f /etc/dhcp/dhclient-exit-hooks.d/fetch-ldap-cert
 rm -f /etc/network/if-up.d/wpad-proxy-update
 sed -i 's/domain-name,//' /etc/dhcp/dhclient-debian-edu.conf
 sed -i 's/domain-search,//' /etc/dhcp/dhclient-debian-edu.conf
 service networking stop
 service networking start
 sed -i 's#NAT=#NAT="10.0.0.0/8"#' /etc/default/enable-nat
 service enable-nat restart
 # You might want a firewall (shorewall or ufw) and traffic shaping.
 #apt update
 #apt install shorewall
 # or
 #apt install ufw
 #apt install wondershaper  
