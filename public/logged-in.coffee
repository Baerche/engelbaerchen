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

window.writeDates = ->
    s = new Date().toString().match(/(.*)GMT/)[1]
    document.write "<small>#{s}</small>"
    document.title = document.title + " " + s

