#go: copy_mix coffee
#go: reinstall dev
go: dev

BROWSE=tools/gen/browse.sh
RM=trash-put
#RM="rm -rf"

dev: coffee TAGS # upload dev
	parse deploy
	#$(BROWSE) "https://dev-engelbaerchen.parseapp.com/add_bearmark?url=u:Test&title=Test"
	#$(BROWSE) https://dev-engelbaerchen.parseapp.com/spiel.html
	$(BROWSE) https://dev-engelbaerchen.parseapp.com/
	
coffee:
	coffee -o public/gen -c public/*.coffee
	coffee -o tools/gen -c tools/*.coffee
	coffee -o cloud/gen -c cloud/*.coffee
	coffee -o mix/mix/gen/ -c mix/mix/*.coffee 
	#coffee -o a-scratch/gen/ -c a-scratch/*.coffee 
	js2coffee a-scratch/to-coffee.js >a-scratch/to-coffee-js.coffee
	
	#eigentlich nicht coffee, aber q&d
	cp -a mix/* cloud/
	cp -a mix/* public/
	sed -i '/<!DOCTYPE html>/,/<body/d; /<\/body>/,/<\html>/ d' public/views/mix/*.ejs


clean:
	$(RM) TAGS
	$(RM) secrets/gen
	$(RM) public/gen
	# $(RM) tools/gen # build by install-*.sh
	$(RM) cloud/gen
	
	$(RM) mix/mix/gen
	$(RM) cloud/mix
	$(RM) cloud/views/mix
	$(RM) public/mix
	$(RM) public/views/mix
	
bear: reinstall #upload bear, like prod-like deploy
	tools/deploy_bear.sh
	chromium-browser https://bearmarklet.parseapp.com/ &

prod: reinstall #upload prod, vorsicht
	tools/deploy_prod.sh
	chromium-browser https://engelbaerchen.parseapp.com/ &
	
mksecrets:
	mkdir -p secrets/gen
	rm config/global.json -f
	ln -s $$PWD/secrets/gen/global.json config/
	rm cloud/gen/global.js -f
	mkdir -p cloud/gen
	ln -s $$PWD/secrets/gen/global.js cloud/gen/
	mkdir -p public/gen
	coffee tools/secrets.coffee

melds:
	meld ~/.ctags tools/dot/ctags
	meld ~/.config/geany/filedefs/filetypes.Coffeescript.conf tools/geany/filedefs/filetypes.Coffeescript.conf
	meld ~/.config/gedit/tools tools/gedit/tools

reinstall: clean mksecrets coffee TAGS
	
TAGS: public/*.coffee
	ctags -e -R public/*.coffee cloud/*.coffee
	
loc: coffee TAGS #local server
	$(BROWSE) http://127.0.0.1:80/baerchen/engelbaerchen/public/tools.html &
	#$(BROWSE) http://127.0.0.1:80/baerchen/engelbaerchen/public/login.html &
	#$(BROWSE) http://127.0.0.1:80/baerchen/engelbaerchen/public/spiel.html &
	#$(BROWSE) http://127.0.0.1:80/baerchen/engelbaerchen/a-scratch/index.html &
	

inst-home:
	tools/install-home.sh

inst-cod:
	tools/install-codio.sh

log:
	tools/log.sh

wget: wget_dir wget_ejs
	cd local-libs;\
	wget -c https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js;\
	wget -c https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js;\
	wget -c https://www.parsecdn.com/js/parse-1.2.18.min.js; \
	wget -c https://embeddedjavascript.googlecode.com/files/ejs_production.js;

wget_dir:
	mkdir -p local-libs

wget_ejs: wget_dir
	cd local-libs; wget -c https://embeddedjavascript.googlecode.com/files/ejs_production.js

