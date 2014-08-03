log = lib.log
ulog = lib.ulog

window.main = ->
    log lib.ajax
    if not lib.ajax then return true
    $ ->
        u = Parse.User.current()
        if u
            ulog 'Für Ajax eingeloggt, hole Infos'
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

window.main()

window.mySubmit = lib.trapHandler (el) ->
    if lib.ajax then return lib.submitAjax(mix.postBearmark,el)

window.dump = ->
    w = (o) -> document.write "#{JSON.stringify o}\n"
    w lib.ajax
    w navigator.userAgent
    w window.opera
