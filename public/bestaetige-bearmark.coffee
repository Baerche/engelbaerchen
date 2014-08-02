log = lib.log
ulog = lib.ulog

window.main = ->
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
