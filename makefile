#go: dev
go: inst-home dev
#go: inst-home bear
#go: loc
##go: inst-cod dev
#go: inst-cod

BROWSE=chromium-browser
#BROWSE=opera

run: dev #compat

bear: #upload bear, like prod-like deploy
	tools/deploy_bear.sh
	chromium-browser https://bearmarklet.parseapp.com/ &

dev: # upload dev
	tools/go.sh
	pwd
	ls tools/gen
	tools/gen/browse.sh https://dev-engelbaerchen.parseapp.com/tools.html
	
inst-home:
	tools/install-home.sh

inst-cod:
	tools/install-codio.sh

sec: #secrets:
	coffee tools/secrets.coffee
	
log:
	tools/log.sh

loc: #local server
	coffee -o public/gen/ -c public/*.coffee 
	coffee -o a-scratch/gen/ -c a-scratch/*.coffee 
	js2coffee a-scratch/index-js.js >a-scratch/gen/index-js.coffee
	
	$(BROWSE) http://127.0.0.1:80/baerchen/engelbaerchen/a-scratch/index.html &
	#$(BROWSE) http://localhost/baerchen/engelbaerchen/a-scratch/index.html &
	#$(BROWSE) http://localhost//baerchen/work/login.html
	#$(BROWSE) http://localhost//baerchen/engelbaerchen/public/edit-bookmarks.html &
	#$(BROWSE) a-scratch/index.html &
	
prod: #upload prod, vorsicht
	tools/deploy_prod.sh
	chromium-browser https://engelbaerchen.parseapp.com/ &
	
wget:
	mkdir -p local-libs
	cd local-libs;\
	wget -c http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js;\
	wget -c http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js;\
	wget -c http://www.parsecdn.com/js/parse-1.2.18.min.js
	


