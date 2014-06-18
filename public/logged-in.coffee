log = lib.log

window.mySubmit = (el) ->
	if ! lib.ajax then return true
	a = $('#eintrag')
	.serializeArray()
	o = {}
	o[el.name] = el.value
	for v in a
		o[v.name] = v.value
	log JSON.stringify o
	mix.postEntwurf(o,{})
	return false

window.main = ->
	if lib.ajax
		log "Eingeloggt für ajax? #{Parse.User.current()}"

window.loeschen = () ->
    elByName "entwurf"
    .value = ''
    return false

elByName = (s) ->
    s = document.getElementsByName s
    s[0]

window.writeDates = ->
    s = new Date().toString().match(/(.*)GMT/)[1]
    log s
    document.getElementById("date").innerHTML = "<small>#{s}</small>"

		
		
