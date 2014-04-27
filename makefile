go: run

run:
	tools/go.sh

sec: #secrets:
	coffee tools/secrets.coffee
	
log:
	tools/log.sh

loc: #local:
	coffee -o public/gen/ public/*.coffee 
	chromium-browser --user-data-dir=$(HOME)/.config/Brackets/live-dev-profile a-scratch/index.html &
	
prod: 
	tools/deploy_prod.sh
	chromium-browser --user-data-dir=$(HOME)/.config/Brackets/live-dev-profile https://engelbaerchen.parseapp.com/ &
	
