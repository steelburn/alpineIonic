#!/bin/sh

sh ./build.sh

watch -n 180 'sh build.sh' &

tail -F /var/log/lighttpd/access.log 2>/dev/null & 
tail -F /var/log/lighttpd/error.log 2>/dev/null 1>&2 &
lighttpd -D -f /etc/lighttpd/lighttpd.conf &
