#!/bin/sh
set -eu
cd $(dirname $0)/..

pwd
export PATH=$PATH:$HOME/bin
#parse --help
parse log -f

