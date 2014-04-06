#!/bin/sh
set -eu
cd $(dirname $0)/..

#downloads
if false; then
mkdir -p ../bin
cd ../bin
wget https://www.parse.com/downloads/cloud_code/parse
chmod +x ../bin/parse
cd -
fi

#links
mkdir -p tools/gen
cat >tools/gen/browse.sh <<SCR
#!/bin/sh
chromium-browser http://engelbaerchen.parseapp.com
#firefox http://engelbaerchen.parseapp.com

sleep 5
parse log

SCR
chmod +x tools/gen/browse.sh

mkdir -p ../secrets
rm config/global.json
ln -s $PWD/../secrets/global.json config/
rm cloud/keys.json.js
ln -s $PWD/../secrets/keys.json cloud/keys.json.js
ls -l ../secrets

meld ~/.config/gedit/tools tools/gedit/tools
coffee tools/secrets.coffee

