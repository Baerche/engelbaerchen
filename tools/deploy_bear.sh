#!/bin/sh
set -eu
cd $(dirname $0)/..

A=Bear
#A=Dev
#A=Prod

B=zz_build_$A

rm public/scratch-* -f

DEV_APPKEY=$(coffee tools/keys.coffee Dev applicationId)
PROD_APPKEY=$(coffee tools/keys.coffee $A applicationId)
echo :$DEV_APPKEY,$PROD_APPKEY.
DEV_JSKEY=$(coffee tools/keys.coffee Dev javascriptKey)
PROD_JSKEY=$(coffee tools/keys.coffee $A javascriptKey)
echo :$DEV_JSKEY,$PROD_JSKEY.

mkdir -p $B
rsync --del -av ./cloud ./config ./public $B/
sed -i.bak s/$DEV_APPKEY/$PROD_APPKEY/ $B/cloud/gen/lib.js
sed -i.bak s/$DEV_APPKEY/$PROD_APPKEY/ $B/public/gen/keys.js
sed -i.bak s/$DEV_JSKEY/$PROD_JSKEY/ $B/public/gen/keys.js
sed -i.bak s/dev-engelbaerchen/engelbaerchen/ $B/public/gen/bearmarklet.js
grep "appKey = " cloud/gen/lib.js 
grep "appKey = " $B/cloud/gen/lib.js 
cat public/gen/keys.js
cat $B/public/gen/keys.js
cat $B/public/gen/bearmarklet.js

cd $B

find . -name "*.coffee" -delete
find . -name "*.bak" -delete

echo deploying $A

parse deploy $A

