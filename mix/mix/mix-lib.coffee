lib = require 'cloud/gen/server-lib'
mix = exports

mix.register = (run) ->
    lib.define_get '/', mix.index, 
        title: "Index"
        main: "gen/logged-in.js"
    if run
        $ ->
            lib.mixes[run]({},{})
    
mix.index = (req, res) ->
  u = Parse.User.current()
  if Parse.User.current()
    u.fetch().then ((u) ->
      json = "Es wird nichts untersucht"
      json = JSON.stringify {ajax: lib.ajax, clientSide: lib.clientSide}, null, 1
      #json = JSON.stringify req.headers, null, 1
      args = 
        username: u.getUsername()
        json: json
        entwurf: u.get("entwurf")
        bookmarks: u.get("bookmarks")
        msg: (if req.msg then req.msg else "")
        pref: lib.appPrefix
        ajax: lib.ajax
      console.log args
      lib.render "logged-in.ejs", args
      if lib.clientSide
        $ ".bookmarks"
        .html args.bookmarks
      true
    ), (error) ->
      console.error error
      lib.render "meldung.ejs",
        message: "Hier drin ging was kaputt."
      return

  else
    lib.redirect "login.html"
  return

