#!/bin/sh
set -eu
IFS='
'
cd $(dirname $0)/..

downloads() {

npm install -g coffee-script 
npm install -g js2coffee 

mkdir -p ../bin
cd ../bin
rm parse
wget https://www.parse.com/downloads/cloud_code/parse
chmod +x parse
cd -

}

downloads_big() {
npm install -g zombie
}

secrets() {

C="$PWD"
rm secrets -f
cd ..

mkdir -p secrets/gen

ln -s $PWD/secrets $C
cd -

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
coffee tools/zombie.coffee
SCR
chmod +x tools/gen/browse.sh
}

#downloads
#downloads_big
secrets
home
