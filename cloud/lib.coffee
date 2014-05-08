_ = require 'underscore'
config = require('cloud/gen/global').content;
lib = exports

# Parse.applicationId missing while deploy
appKey = "XvfIKW98ROlBjl9RHwZYqRwnOsUbI87MTlbUNY6L" #Dev

lib.listUsers = (users) ->
	[ users.length,
		( [u.get('username'), u.get('entwurf')] for u in users )
	]
	
lib.addBearmark = (user, query) ->
    b = user.get 'bookmarks'
    u = _.escape query.url
    u = """<a href="#{u}">[#{_.escape query.title} | #{u}]</a><br>\n"""
    b = u + b
    user.set 'bookmarks', b
   
lib.addToBookmarks = (user, rawtext) ->
    b = user.get 'bookmarks'
    r = rawtext.replace /\r\n/g, '. '
    b = "{#{r}}<br>#{b}"
    user.set 'bookmarks', b

appFromKey = (key,apps) ->
	for i of apps
		if apps[i].applicationId == key
			return [i, apps[i]]
	return null

lib.appName = () ->
	a = appFromKey appKey, config.applications
	a[0]

lib.appKeys = () ->
	a = appFromKey appKey, config.applications
	a[1]

lib.appPrefix = "#{if lib.appName()=='Dev' then 'Dev-' else ''}"

