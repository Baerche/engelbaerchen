#!/bin/sh
#todo cloud/keys.json link
#tools/gen/browse.sh erstellen

set -eu
cd $(dirname $0)/..

#downloads
if false; then

npm install -g coffee-script 

mkdir -p ../bin
cd ../bin
rm parse
wget https://www.parse.com/downloads/cloud_code/parse
chmod +x ../bin/parse

npm install -g zombie

fi

#links
mkdir -p tools/gen
cat >tools/gen/browse.sh <<SCR
#!/bin/sh
coffee tools/zombie.coffee
SCR
chmod +x tools/gen/browse.sh


mkdir -p ../secrets
rm config/global.json || true
ln -s $PWD/../secrets/global.json config/
rm cloud/keys.json.js || true
ln -s $PWD/../secrets/keys.json cloud/keys.json.js
ls -l ../secrets

coffee tools/secrets.coffee