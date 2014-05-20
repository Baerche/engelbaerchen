log = lib.log
ulog = lib.ulog

window.main = ->
	if not lib.ajax then log "kein ajax"; return true
	u = Parse.User.current()
	if u
		ulog 'Eingeloggt, hole Infos'
		u.fetch()
		.then (u) ->
			s = u.get 'username'
			ulog 'Hallo ' + s
			$ '#name'
			.text s + '?'
			$ '#username'
			.val s
		, (e) -> log e
	else
		ulog 'Nicht eingeloggt'

window.login = () ->
	if not lib.ajax then return true
	username = $("#username").val()
	password = $("#password").val()
	#log [username,password]
	log 'logging in für ajax'
	Parse.User.logIn username, password
	.then () ->
		log 'logged in für ajax, logging in web'
		$ '#robot'
		.attr 'name','bekannt'
		setTimeout ->
			$ "#form"
			.submit()
		, 0
	, (e) ->
		log "fehlschlag #{e}"
	false
	
