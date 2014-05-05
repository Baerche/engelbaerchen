log = lib.log
ulog = lib.ulog

window.main = ->
	if lib.keinGrosserBrowserDannZurueck() then return true
	$ ->
		u = Parse.User.current()
		if u
			ulog 'Eingeloggt, hole Bookmarks und so'
			u.fetch()
			.then (u) ->
				s = u.get 'username'
				ulog 'Hallo ' + s
				s = u.get 'bookmarks'
				$ '#bookmarks'
				.html s
			, (e) -> log e
		else
			ulog 'Nicht eingeloggt'

window.speichern = ->
	u = Parse.User.current()
	if u
		ulog 'Speichere'
		u.fetch()
		.then (u) ->
			s = $ '#bookmarks'
			.html()
			u.set 'bookmarks', s
			u.save().then ->
				ulog "Gespeichert #{new Date()}"
			, (e) -> alert ulog 'Speichern fehlgeschlagen ' + e
	else
		alert ulog 'Nicht eingeloggt, kein Speichern'

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

