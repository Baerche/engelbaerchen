#!/bin/sh
set -eu
IFS='
'
cd $(dirname $0)/..

make fixtabs

