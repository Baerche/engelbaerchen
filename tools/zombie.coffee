Browser = require 'zombie'
assert = require 'assert'

console.log u = 'https://dev-engelbaerchen.parseapp.com/login.html'
#console.log u = 'https://dev-engelbaerchen.parseapp.com'

src = (o) -> console.log o.toString()
descro = (o) -> console.log Object.keys(o)
ewrap = (f) ->
	(args...) ->
		try f args...
		catch e
			console.trace "ewrap catched:"
			console.log e
			console.log f.toString()

p = require 'zombie/package.json'
console.log [p.name, p.version]
#return

b = new Browser(debug: true)
b.visit u
.then ewrap () ->
	console.log JSON.stringify [ b.success, b.statusCode, b.errors ]
	console.log b.location.href
	console.log b.html()
	b.fill 'username','b'
	b.fill 'password','c'
	#console.log b.html()
	b.pressButton 'bekannt'
#return
.then ewrap () ->
	console.log 'done:'
	console.log JSON.stringify [ b.success, b.statusCode, b.errors ]
	#b.dump()
	console.log b.location.href
	console.log b.html()
	#console.log b.saveCookies()
	console.log '---'

