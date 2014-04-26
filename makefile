go: run

run:
	tools/go.sh

secrets:
	coffee tools/secrets.coffee
	
log:
	tools/log.sh

loc: #local
	coffee -o public/gen/ public/*.coffee 
	chromium-browser --user-data-dir=$(HOME)/.config/Brackets/live-dev-profile a-scratch/index.html &
