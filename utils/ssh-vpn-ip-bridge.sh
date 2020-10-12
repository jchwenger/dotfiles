# https://unix.stackexchange.com/a/243033
ip rule add table 128 from 192.168.1.20 # public ip
ip route add table 128 to 192.168.1.0/24 dev wlo1 # public ip subnet
ip route add table 128 default via 192.168.1.1 # default gateway

# -------------------------------------------------------------------------
# issue with openconnect: web does not seem to work after it shuts down
# (perhaps only with the routing in question?)

# tentative solution:
# https://askubuntu.com/questions/1088950/no-internet-connection-after-disconnecting-from-vpn-in-    ubuntu-18-04
# https://bugs.launchpad.net/ubuntu/+source/ppp/+bug/1778946

# edit /etc/ppp/ip-up.d/0000usepeerdns
# replace:
# cp -a "$REALRESOLVCONF" "$REALRESOLVCONF.pppd-backup.$PPP_IFACE"
# with:
# cp "$REALRESOLVCONF" "$REALRESOLVCONF.pppd-backup.$PPP_IFACE"
# chmod 644 "$REALRESOLVCONF.pppd-backup.$PPP_IFACE"
# restart network manager
# systemctl restart NetworkManager
# !! ROUTING ABOVE NEEDS TO BE REDONE

# manual solution:
# sudo service network-manager reload
