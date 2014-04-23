#!/bin/sh
set -eu
cd $(dirname $0)/..

pwd
export PATH=$PATH:$HOME/bin
#parse --help
echo watching parse.com
parse develop Mock &
#coffee stopps silently on errors
#echo watching coffee;(coffee -o public/gen -c public/ || echo "coffee stoppt") &
#coffee  -o tools/gen -c tools/*.coffee
#coffee  -o cloud/gen -c cloud/*.coffee
jobs 
read -p beenden? t
pkill -f parse
exit

