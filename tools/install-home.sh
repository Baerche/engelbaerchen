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

secrets() {

mkdir -p secrets/gen

rm config/global.json -f
ln -s $PWD/secrets/gen/global.json config/

rm cloud/gen/global.js -f
ln -s $PWD/secrets/gen/global.js cloud/gen/

coffee tools/secrets.coffee

}

home() {
#prep test
mkdir -p tools/gen
cat >tools/gen/browse.sh <<SCR
#!/bin/sh
set -eu
IFS='
'
cd $(dirname $0)/..

chromium-browser \$1
#ex
#chromium-browser https://dev-engelbaerchen.parseapp.com
#firefox https://dev-engelbaerchen.parseapp.com
#opera  https://dev-engelbaerchen.parseapp.com
SCR
chmod +x tools/gen/browse.sh
}

melds() {
meld ~/.ctags tools/dot/ctags
meld ~/.config/geany/filedefs/filetypes.Coffeescript.conf tools/geany/filedefs/filetypes.Coffeescript.conf
meld ~/.config/gedit/tools tools/gedit/tools
}

#downloads
#downloads_big
secrets
home
melds
