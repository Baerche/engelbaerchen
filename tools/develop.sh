#!/bin/sh
set -eu
cd $(dirname $0)/..

pwd
export PATH=$PATH:$HOME/bin
#parse --help
echo watching parse.com
parse develop Mock

