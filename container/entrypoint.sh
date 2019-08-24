#!/bin/sh
OPTIONS=$@
RNDCFILE=/root/rndc.key
#Deploy rndc from $RNDCFILE to /etc/bind linking it.
if test -f "$RNDCFILE"; then
    rm -vf /etc/bind/rndc.key
    ln -vs $RNDCFILE /etc/bind/rndc.key
else
  echo "$RNDCFILE not found. You might have problems using $(which rndc) to control the daemon. Skipping..."
fi
chown -R root:named /etc/bind /var/run/named
chown -R named:named /var/cache/bind
chmod -R 770 /var/cache/bind /var/run/named
chmod -R 750 /etc/bind
# Run in foreground and log to STDERR (console):
exec /usr/sbin/named -c /etc/bind/named.conf -g -u named $OPTIONS
