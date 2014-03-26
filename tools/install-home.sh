#!/bin/sh
set -eu
cd $(dirname $0)/..

if false; then
mkdir -p ../bin
cd ../bin
wget https://www.parse.com/downloads/cloud_code/parse
chmod +x ../bin/parse
cd -
fi

mkdir -p tools/gen
cat >tools/gen/browse.sh <<SCR
#!/bin/sh
firefox http://engelbaerchen.parseapp.com
SCR
chmod +x tools/gen/browse.sh

mkdir -p ../secrets
rm config/global.json
ln -s $PWD/../secrets/global.json config/
ls -l ../secrets

