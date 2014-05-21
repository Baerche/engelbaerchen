log = lib.log
ulog = lib.ulog

window.main = ->
	$ ->
		u = Parse.User.current()
		if u
			ulog 'Eingeloggt, hole Infos'
			u.fetch()
			.then (u) ->
				s = u.get 'username'
				ulog 'Hallo ' + s
			, (e) -> log e
		else
			ulog 'Nicht eingeloggt'
