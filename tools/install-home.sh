#!/bin/sh
set -eu
IFS='
'
cd $(dirname $0)/..

downloads() {

#npm install -g coffee-script 
#npm install -g js2coffee 

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
echo BROWER
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
make reinstall
browser
