#!/bin/sh
#todo move secrets to parent per link, like
#rm secrets; ln -s $PWD/../secrets .
#todo if secrets are visitor-visible

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
chmod +x ../bin/parse


}

downloads_big() {
npm install -g zombie
}

rest() {

#prep test
mkdir -p tools/gen
cat >tools/gen/browse.sh <<SCR
#!/bin/sh
coffee tools/zombie.coffee
SCR
chmod +x tools/gen/browse.sh

#links

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

pwd
coffee tools/secrets.coffee

}

#downloads
#downloads_big
rest
