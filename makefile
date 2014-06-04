go: dev

BROWSE=tools/gen/browse.sh
RM=trash-put
#RM="rm -rf"

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
	
coffee:
	coffee  -o public/gen -c public/*.coffee
	coffee  -o tools/gen -c tools/*.coffee
	coffee  -o cloud/gen -c cloud/*.coffee
	coffee -o a-scratch/gen/ -c a-scratch/*.coffee 
	js2coffee a-scratch/to-coffee.js >a-scratch/to-coffee-js.coffee

dev: coffee TAGS # upload dev
	parse deploy
	$(BROWSE) "https://dev-engelbaerchen.parseapp.com/add_bearmark?url=u:Test&title=Test"
	#$(BROWSE) https://dev-engelbaerchen.parseapp.com/spiel.html
	#$(BROWSE) https://dev-engelbaerchen.parseapp.com/
	
clean:
	$(RM) TAGS
	$(RM) secrets/gen
	$(RM) public/gen
	$(RM) tools/gen
	$(RM) cloud/gen
	
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

wget:
	mkdir -p local-libs
	cd local-libs;\
	wget -c http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js;\
	wget -c http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js;\
	wget -c http://www.parsecdn.com/js/parse-1.2.18.min.js
	


