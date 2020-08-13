#!/bin/sh

# This script should run periodically to create new builds.
export PYTHON=/usr/bin/python

cd /app/project
git stash && git stash drop
A=$(git pull --recurse-submodules --all | grep -sE "(Already up to date.|origin/master)" | wc -l)
if [ "$A" == "0" ] 
  then
    rm .DIRTY
    npm i
    ionic build --engine=browser || touch .DIRTY
else
  if [ -f .DIRTY ]; then
    rm .DIRTY
    npm i 
    ionic build --engine=browser || touch .DIRTY
  else
    echo "No new build required."
  fi
fi
