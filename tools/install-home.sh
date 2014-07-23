#!/bin/sh
set -eu
IFS='
'
cd $(dirname $0)/..

downloads() {

#npm install -g coffee-script 
#npm install js2coffee 
#npm install ejs

mkdir -p ../bin
cd ../bin
trash-put parse
wget https://www.parse.com/downloads/cloud_code/parse
chmod +x parse
cd -

}

downloads_big() {
    echo nop
}

browser() {
#prep test
echo BROWSER
mkdir -p tools/gen
cat >tools/gen/browse.sh <<SCR
#!/bin/sh
set -eu
IFS='
'
cd $(dirname $0)/..

chromium-browser \$1 &
#firefox  \$1 &
SCR
chmod +x tools/gen/browse.sh
}

#downloads
#downloads_big
cp -au ~/node_modules/ejs/ejs.min.js public/x
make reinstall
browser
