log = lib.log

window.main = ->
    if lib.ajax
        log "Eingeloggt für ajax? #{Parse.User.current()}"

window.mySubmit = (el) ->
    if lib.ajax then return lib.submitAjax(mix.postEntwurf,el)

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

        
        
