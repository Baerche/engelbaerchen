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
    r = rawtext.replace /(\b(?:http|https|ftp)\:\S.*?)(\s|$)/g,'<a href="$1">$1</a>$2'
    r = r.replace /\r\n/g, '. '
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

#
# für mix
#

lib.clientSide = false

lib.appPrefix = "#{if lib.appName()=='Dev' then 'Dev-' else ''}"

lib.define_get = (path, fun, ajax) ->
	lib.app.get path, (req, res) ->
		lib.ajax = ! req.headers["user-agent"].match /Opera Mini/
		if lib.ajax
			res.render "ajax", 
				path: path
				ajax: ajax
		else
			lib.res = res
			fun req.query, res

lib.render = (tmpl, data) ->
	lib.res.render "mix/" + tmpl, data
	
lib.redirect = (url) ->
	lib.res.redirect url
