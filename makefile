go: inst-cod dev
#go: inst-cod

run: dev #compat

dev: # upload dev
	tools/go.sh
	
inst-cod:
	tools/install-codio.sh

sec: #secrets:
	coffee tools/secrets.coffee
	
log:
	tools/log.sh

BROWSE=chromium-browser
#BROWSE=opera

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
	chromium-browser --user-data-dir=$(HOME)/.config/Brackets/live-dev-profile https://engelbaerchen.parseapp.com/ &
	
wget:
	mkdir -p local-libs
	cd local-libs;\
	wget -c http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js;\
	wget -c http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js;\
	wget -c http://www.parsecdn.com/js/parse-1.2.18.min.js
	


