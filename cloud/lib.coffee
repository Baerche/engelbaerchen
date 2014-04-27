_ = require 'underscore'
config = require('cloud/gen/global').content;

# Parse.applicationId missing while deploy
appKey = "XvfIKW98ROlBjl9RHwZYqRwnOsUbI87MTlbUNY6L" #Dev

exports.listUsers = (users) ->
	[ users.length,
		( [u.get('username'), u.get('entwurf')] for u in users )
	]
	
exports.addBearmark = (user, query) ->
    b = user.get 'bookmarks'
    u = _.escape query.url
    u = """<a href="#{u}">[#{_.escape query.title} | #{u}]</a><br>\n"""
    b = u + b
    user.set 'bookmarks', b
   
exports.addToBookmarks = (user, rawtext) ->
    b = user.get 'bookmarks'
    b = rawtext + b
    user.set 'bookmarks', b
    
appFromKey = (key,apps) ->
	for i of apps
		if apps[i].applicationId == key
			return [i, apps[i]]
	return null

exports.appName = () ->
	a = appFromKey appKey, config.applications
	a[0]

exports.appKeys = () ->
	a = appFromKey appKey, config.applications
	a[1]
	
