log = lib.log

window.main = ->
	log "Eingeloggt für ajax? #{Parse.User.current()}"

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
	
