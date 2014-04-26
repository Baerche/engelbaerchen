window.loeschen = () ->
    elByName "entwurf"
    .value = ''
    return false

elByName = (s) ->
    s = document.getElementsByName s
    s[0]
