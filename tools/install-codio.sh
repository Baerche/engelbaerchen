#!/bin/sh
#todo cloud/keys.json link
#tools/gen/browse.sh erstellen

set -eu
cd $(dirname $0)/..

npm install -g coffee-script 

mkdir -p ../bin
cd ../bin
wget https://www.parse.com/downloads/cloud_code/parse
chmod +x ../bin/parse

npm install -g zombie

