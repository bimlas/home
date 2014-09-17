#!/bin/bash

# Masold a /etc/init.d konyvtarba, majd:
#   update-rc.d tuzfal.sh defaults

### BEGIN INIT INFO
# Provides:          tuzfal
# Required-Start:
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      S
# Short-Description: tuzfal by tmms @ hup.hu, log: /var/log/syslog
### END INIT INFO

echo " * TUZFAL BEALLITASA"

# Megkeressuk az iptables es a modprobe binarisait.
IPTABLES=`which iptables`
MODPROBE=`which modprobe`
# Megadjuk a modulkonyvtarat.
MODKT=/lib/modules/`uname -r`/kernel/net/ipv4/netfilter
# Kivesszuk az ipcimunket.
IFACE=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | \
       awk '{ print $1 }' \
      `
# Eloszor torlunk minden szabalyt.
                                                     # Erre meg ra kene nezni,
                                               # hogy nem lehet-e egyszerubben
                                                                  # megoldani.
$IPTABLES -P INPUT ACCEPT
$IPTABLES -P FORWARD ACCEPT
$IPTABLES -P OUTPUT ACCEPT
$IPTABLES -F
$IPTABLES -X
$IPTABLES -Z

# Felallitjuk az alap szabalyokat (policy), azaz minden bejovo kapcsolatot
# tiltunk.
$IPTABLES -P INPUT DROP
$IPTABLES -P OUTPUT ACCEPT
$IPTABLES -P FORWARD DROP
echo 1 > /proc/sys/net/ipv4/ip_forward

# Megnezzuk vannak e modulok, amiket betoltunk - az ftp koveto modul, betolti
# majd a tobbi modult.
if [ -f $MODKT/ip_conntrack_ftp.ko ] ; then
    MOD=ip_conntrack_ftp
    $MODPROBE $MOD
fi
if [ -f $MODKT/ip_nat_ftp.ko ] ; then
    MOD2=ip_nat_ftp ;
    $MODPROBE $MOD2
fi

# Figyeljuk a syn sutiket.
echo 1 > /proc/sys/net/ipv4/tcp_syncookies

# Bekapcsoljuk a forrascimhitelesitest.
echo 1 > /proc/sys/net/ipv4/conf/default/rp_filter
#for spoofing in /proc/sys/net/ipv4/conf/default/rp_filter; do
#        echo '1' > $spoofing
#done

# ............................ INPUT SZABALYOK ...............................

# A loopback bejovo kapcsolatai engedelyezve maradnak.
$IPTABLES -A INPUT -i lo -j ACCEPT

# ... tovabba azok is, amik tolunk szarmaznak.
$IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Figyeljuk, hogy a tcp kapcsolatok, tenyleg a syn bittel kezdodjenek.
$IPTABLES -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
$IPTABLES -N syn-flood
$IPTABLES -A INPUT -p tcp --syn -j syn-flood
$IPTABLES -A syn-flood -m limit --limit 1/s --limit-burst 4 -j RETURN
$IPTABLES -A syn-flood -j LOG --log-prefix '*** HACK: SYN-Flood attack :'
$IPTABLES -A syn-flood -p tcp --syn -j DROP

# Nmap FIN/URG/PSH
$IPTABLES -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -m limit --limit 5/m \
  -j LOG --log-prefix '*** HACK: Nmap XMAS scan :'
$IPTABLES -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP

# SYN/RST
$IPTABLES -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -m limit --limit 5/m \
  -j LOG --log-prefix '*** HACK: SYN/RST scan :'
$IPTABLES -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP

# SYN/FIN
$IPTABLES -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -m limit --limit 5/m \
  -j LOG --log-prefix '*** HACK: SYN/FIN scan :'
$IPTABLES -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP

# Portscan,PoD
$IPTABLES -A INPUT -p tcp --tcp-flags ALL ALL \
  -j LOG --log-prefix '*** HACK: XMAS-tree scan :'
$IPTABLES -A INPUT -p tcp --tcp-flags ALL NONE -m state ! \
  --state ESTABLISHED -j LOG --log-prefix '*** HACK: NULL scan :'

exit 0

# vim: fileformat=unix
