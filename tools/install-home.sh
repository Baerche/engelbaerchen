#!/bin/sh
set -eu
cd $(dirname $0)/..

#downloads
if false; then
mkdir -p ../bin
cd ../bin
trash-put parse
wget https://www.parse.com/downloads/cloud_code/parse
chmod +x parse
cd -
fi

#links
mkdir -p tools/gen
cat >tools/gen/browse.sh <<SCR
#!/bin/sh
chromium-browser https://dev-engelbaerchen.parseapp.com
#firefox https://dev-engelbaerchen.parseapp.com
#opera  https://dev-engelbaerchen.parseapp.com

#sleep 5; parse log

SCR
chmod +x tools/gen/browse.sh

mkdir -p secrets/gen

rm cloud/gen/global.js -f
ln -s $PWD/secrets/gen/global.js cloud/gen/global.js

ls -l secrets

meld ~/.config/gedit/tools tools/gedit/tools
coffee tools/secrets.coffee


