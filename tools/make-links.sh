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
mkdir -p $D/gen
#toto find
#ln -s $S/* $D
#find public -name *.coffee #-exec echo\;
find a-scratch/ -type l  -exec rm {} +

cd $D

cp -s  $S/*.html $S/*.css $S/*.js $S/*.coffee .
ln -s $S/gen/keys.js gen
rm *~ -f
ls -l
ls

