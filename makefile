go: run

run:
	tools/go.sh

sec: #secrets:
	coffee tools/secrets.coffee
	
log:
	tools/log.sh

BROWSE=chromium-browser --user-data-dir=$(HOME)/.config/Brackets/live-dev-profile
loc: #local:
	coffee -o public/gen/ public/*.coffee 
	$(BROWSE) http://localhost://baerchen/work/login.html
#	chromium-browser --user-data-dir=$(HOME)/.config/Brackets/live-dev-profile http://localhost://baerchen/work/login-ajax.html &
	#chromium-browser --user-data-dir=$(HOME)/.config/Brackets/live-dev-profile http://localhost://baerchen/work/edit-bookmarks.html &
	#	chromium-browser --user-data-dir=$(HOME)/.config/Brackets/live-dev-profile a-scratch/index.html &
	
prod: 
	tools/deploy_prod.sh
	chromium-browser --user-data-dir=$(HOME)/.config/Brackets/live-dev-profile https://engelbaerchen.parseapp.com/ &
	
