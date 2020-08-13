#!/bin/sh

# Initialization:
# Do a clean slate & clone repo from git if $GITREPO variable is set
if [ -z "$GITREPO" ]; then
  echo "GITREPO variable not set. Assuming existing project is available."
else
  rm -rf /app/project
  git clone --recurse-submodules --shallow-submodules --depth=1 $GITREPO /app/project
  cd /app/project
  git submodule foreach --recursive git reset --hard
  npm i
  ionic build --engine=browser
fi

# sh ./build.sh

tail -F /var/log/lighttpd/access.log 2>/dev/null & 
tail -F /var/log/lighttpd/error.log 2>/dev/null 1>&2 &
lighttpd -D -f /etc/lighttpd/lighttpd.conf &

sleep 10m && watch -n 180 'sh /app/build.sh'
