go: clean TAGS
#go: dev
#go: inst-home dev
#go: inst-home bear
##go: inst-cod dev
#go: inst-cod

BROWSE=tools/gen/browse.sh

clean:
	rm TAGS

TAGS: public/*.coffee
	ctags -e -R public/*.coffee
	
loc: #local server
	coffee -o public/gen/ -c public/*.coffee 
	coffee -o a-scratch/gen/ -c a-scratch/*.coffee 
	js2coffee a-scratch/index-js.js >a-scratch/gen/index-js.coffee
	
	$(BROWSE) http://127.0.0.1:80/baerchen/engelbaerchen/public/tools.html &
	#$(BROWSE) http://127.0.0.1:80/baerchen/engelbaerchen/public/login.html &
	#$(BROWSE) http://127.0.0.1:80/baerchen/engelbaerchen/public/spiel.html &
	#$(BROWSE) http://127.0.0.1:80/baerchen/engelbaerchen/a-scratch/index.html &
	

bear: #upload bear, like prod-like deploy
	tools/deploy_bear.sh
	chromium-browser https://bearmarklet.parseapp.com/ &

dev: # upload dev
	tools/go.sh
	pwd
	ls tools/gen
	$(BROWSE) https://dev-engelbaerchen.parseapp.com/spiel.html
	#$(BROWSE) https://dev-engelbaerchen.parseapp.com/
	
inst-home:
	tools/install-home.sh

inst-cod:
	tools/install-codio.sh

sec: #secrets:
	coffee tools/secrets.coffee
	
log:
	tools/log.sh

prod: #upload prod, vorsicht
	tools/deploy_prod.sh
	chromium-browser https://engelbaerchen.parseapp.com/ &
	
wget:
	mkdir -p local-libs
	cd local-libs;\
	wget -c http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js;\
	wget -c http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js;\
	wget -c http://www.parsecdn.com/js/parse-1.2.18.min.js
	


