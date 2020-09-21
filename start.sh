#!/bin/sh

# Initialization:

export PYTHON=/usr/bin/python

# Do a clean slate & clone repo from git if $GITREPO variable is set
if [ -z "$GITREPO" ]; then
  echo "GITREPO variable not set. Assuming existing project is available."
else
  rm -rf /app/project/*
  rm -rf /app/project/.git
  git clone --recurse-submodules --shallow-submodules --depth=1 $GITREPO /app/project
  cd /app/project
  git submodule foreach --recursive git reset --hard
  npm i
fi

# Now, choose whether to build and let lighttpd serve, or serve using `ng serve`:
if [ "$SERVE" == "true" ]; then
  if [ "$SSL" == "true" ]; then
    PARAM=--ssl
# Check that the KEY & CERT files exist and readable
    if [ -r $KEYPATH ]; then
      PARAM=$PARAM --key-path=$KEYPATH
      echo KEYPATH is available, so PARAM=$PARAM
    fi
    if [ -r $CERTPATH ]; then
      PARAM=$PARAM --cert-path=$CERTPATH
      echo CERTPATH is available, so PARAM=$PARAM
    fi
  fi
  ionic serve --external --disableHostCheck $PARAM &
else
  ionic build --engine=browser
  tail -F /var/log/lighttpd/access.log 2>/dev/null & 
  tail -F /var/log/lighttpd/error.log 2>/dev/null 1>&2 &
  lighttpd -D -f /etc/lighttpd/lighttpd.conf &
fi

sleep 10m && watch -n 180 'sh /app/build.sh'

