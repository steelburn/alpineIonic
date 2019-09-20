#!/bin/sh

# This script should run periodically to create new builds.

cd /app/project
A=$(git pull | grep -s "Already up to date." | wc -l)
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
