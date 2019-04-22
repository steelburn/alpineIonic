#!/bin/sh
cd project
watch -n 120 'git pull' &
if [ "$NPM_PROXY" -ne "" ]; then
  PROXY_PARAMS="--proxy $NPM_PROXY --https-proxy $NPM_PROXY --strict-ssl false"
fi
if [ "$LIVERELOAD" -ne "n" ]; then
  NOLIVERELOAD_PARAM="--nolivereload"
  npm $PROXY_PARAMS i && ionic serve --no-open $NOLIVERELOAD_PARAM
