#!/bin/sh
set -eu
cd $(dirname $0)/..

pwd
export PATH=$PATH:$HOME/bin
#parse --help
coffee  -o public/gen -c public/*.coffee
coffee  -o tools/gen -c tools/*.coffee
coffee  -o cloud/gen -c cloud/*.coffee
echo $PATH
echo deploying; parse deploy
tools/gen/browse.sh
