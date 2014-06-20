log = lib.log

window.mySubmit = (el) ->
	return lib.submitAjax(mix.postEntwurf,el)

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

		
		
