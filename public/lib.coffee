window.lib = {}
exports = window.lib

window.onerror = (errorMsg, url, lineNumber) ->
	alert JSON.stringify [
		'Hi Progger. window.onerror', errorMsg, url, lineNumber]

window.main = ->
	alert 'Hallo Progger, kein Main! Bitte eins schreiben'


if not window.operamini
	lib.ajax = true
	document.write """
		<script src="//www.parsecdn.com/js/parse-1.2.18.min.js"></script>
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js"></script>
		<script src="gen/keys.js"></script>
	"""
	log = (o) ->
		console.log o
		$ '#log'
		.append "#{if o then o.toString() else o}\n"
		o
else
	lib.ajax = false
	log = (o) -> o
exports.log = log
	
window.logout = () ->
	if not lib.ajax then return true
	log 'logging out ajax'
	Parse.User.logOut()
	true


