#!/bin/sh
set -eu
cd $(dirname $0)/..

pwd
export PATH=$PATH:$HOME/bin
#parse --help
coffee  -o public/gen -c public/scratch.coffee
coffee  -o tools/gen -c tools/scratch.coffee
echo $PATH
parse deploy
#coffee tools/zombie.coffee
tools/gen/browse.sh
