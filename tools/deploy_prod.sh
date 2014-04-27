#!/bin/sh
set -eu
cd $(dirname $0)/..

B=zz_build_prod

#coffee tools/keys.coffee Prod applicationId; exit

DEV_APPKEY=$(coffee tools/keys.coffee Dev applicationId)
PROD_APPKEY=$(coffee tools/keys.coffee Prod applicationId)
echo :$DEV_APPKEY,$PROD_APPKEY.
mkdir -p $B
rsync --del -av ./cloud ./config ./public $B/
sed -i.bak s/$DEV_APPKEY/$PROD_APPKEY/ $B/cloud/gen/lib.js
grep "appKey = " cloud/gen/lib.js 
grep "appKey = " $B/cloud/gen/lib.js 

echo deploying Prod
cd $B
parse deploy Prod

