log = lib.log
ulog = lib.ulog

window.main = ->
    log debug.NOT_SIM_OMI
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
        ulog 'Nicht für ajax eingeloggt'

window.login = () ->
    if not lib.ajax then return true
    username = $("#username").val()
    password = $("#password").val()
    #log [username,password]
    log 'logging in für ajax'
    Parse.User.logIn username, password
    .then () ->
        log 'logged in für ajax, und los'
        location.href = "/"
    , (e) ->
        log "fehlschlag #{e}"
    false
    
window.register = () ->
    if not lib.ajax then return true
    username = $("#username").val()
    password = $("#password").val()
    #log [username,password]
    log 'Registriere per ajax'
    Parse.User.signUp username, password, ACL: new Parse.ACL()
    .then () ->
        log 'registriert per ajax, logging in web'
        window.login()
    , (e) ->
        log "fehlschlag #{e}"
    false
    
