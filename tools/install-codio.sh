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
make reinstall
home
