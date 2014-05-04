log = lib.log

window.main = ->
	if lib.keinGrosserBrowserDannZurueck() then return true
	$ ->
		u = Parse.User.current()
		if u
			log 'Eingeloggt, hole Bookmarks und so'
			u.fetch()
			.then (u) ->
				s = u.get 'username'
				log 'Hallo ' + s
				s = u.get 'bookmarks'
				$ '#bookmarks'
				.html s
			, (e) -> log e
		else
			log 'Nicht eingeloggt'

window.speichern = ->
	u = Parse.User.current()
	if u
		log 'Speichere'
		u.fetch()
		.then (u) ->
			s = $ '#bookmarks'
			.html()
			u.set 'bookmarks', s
			u.save().then ->
				log 'Gespeichert'
			, (e) -> alert log 'Speichern fehlgeschlagen ' + e
	else
		alert log 'Nicht eingeloggt, kein Speichern'

window.edit = ->
	s = $ '#edit'
	.html()
	if s == 'Edit'
		$ '#bookmarks'
		.attr 'contenteditable',true
		$ '#edit'
		.html 'Test'
	else
		$ '#bookmarks'
		.attr 'contenteditable',false
		$ '#edit'
		.html 'Edit'
	true

