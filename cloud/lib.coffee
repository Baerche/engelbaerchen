_ = require 'underscore'

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
    
    
