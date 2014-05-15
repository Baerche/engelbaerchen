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
	console.log '---login'
	#console.log JSON.stringify [ b.success, b.statusCode, b.errors ]
	b.fill 'username','a'
	b.fill 'password','b'
	#console.log b.html()
	b.pressButton 'bekannt'
#return
.then ewrap () ->
	console.log '---hauptseite'
.then ewrap () ->
	console.log '---eintragen'
	b.fill 'entwurf', """
		#{new Date()}\r
		http://url0 ein ahttp://<>url1 text: :mit xu://url2\r
		mehreren zeilen http://<>url3 http://url4
	"""
	console.log b.html()
	#b.pressButton 'Speichern'
	b.pressButton 'Eintragen'
.then () ->
	console.log '---done'
	console.log b.html()
	