log = lib.log

window.main = ->
	log "Eingeloggt für ajax? #{Parse.User.current()}"

window.loeschen = () ->
    elByName "entwurf"
    .value = ''
    return false

elByName = (s) ->
    s = document.getElementsByName s
    s[0]
