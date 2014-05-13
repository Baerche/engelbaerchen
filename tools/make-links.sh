#!/bin/sh
set -eu
IFS='
'
cd $(dirname $0)/..

S=$PWD
D=$HOME/www
DD=$D/engelbaerchen
mkdir -p $D
rm -f $DD
ln -s $S $DD

S=$PWD/public
D=$PWD/a-scratch
mkdir -p $D
#toto find
#ln -s $S/* $D
#find public -name *.coffee #-exec echo\;
find a-scratch/ -maxdepth 1 -type l  -exec rm {} +
cd a-scratch

S=../public
cp -s  $S/*.html $S/*.css $S/*.js $S/*.coffee .
rm *~ -f
ls -l
ls

