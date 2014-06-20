lib = require 'cloud/gen/server-lib'
_ = require 'underscore'
mix = exports

mix.register = (run) ->
    lib.defineGet '/', mix.index, 
        title: "Index"
        mainScript: "gen/logged-in.js"
    lib.definePost '/', mix.postEntwurf, 
        title: "Index"
        mainScript: "gen/logged-in.js"
    if run
        $ ->
            lib.trap(lib.gets[run])({}, new lib.AjaxRes())
    
mix.index = (req, res, msg) ->
  u = Parse.User.current()
  if u
    u.fetch().then ((u) ->
      json = "Es wird nichts untersucht"
      json = JSON.stringify {ajax: lib.ajax, clientSide: lib.clientSide}, null, 1
      #json = JSON.stringify req.headers, null, 1
      args = 
        username: u.getUsername()
        json: json
        entwurf: u.get("entwurf")
        bookmarks: u.get("bookmarks")
        msg: if msg then msg else ""
        pref: lib.appPrefix
        ajax: lib.ajax
      res.render "mix/logged-in.ejs", args
      if lib.clientSide
        $ ".bookmarks"
        .html args.bookmarks
      true
    ), (error) ->
      console.error error
      res.render "mix/meldung.ejs",
        message: "Hier drin ging was kaputt."
      return

  else
    lib.redirect "login.html"
  return

mix.addToBookmarks = (user, rawtext) ->
    b = user.get 'bookmarks'
    r = rawtext.replace /(\b(?:http|https|ftp)\:\S.*?)(\s|$)/g,'<a href="$1">$1</a>$2'
    r = r.replace /\r\n/g, '. '
    b = "{#{r}}<br>#{b}"
    user.set 'bookmarks', b


mix.postEntwurf = (req, res) ->
  u = Parse.User.current()
  if u
    msg = "Gespeichert"
    u = u.fetch().then((u) ->
      if req.Eintragen
        mix.addToBookmarks u, _.escape(req.entwurf)
        msg += " und eingetragen"
        u.set "entwurf", ""
      else
        u.set "entwurf", req.entwurf
      u.save()
    ).then(->
        mix.index req, res, msg
    , (u, error) ->
      res.render "mix/meldung.ejs",
        message: "Was kaputt. Konnte Entwurf nicht speichern. "
      return
    )
  else
    lib.render "mix/meldung.ejs",
      message: "He dich gibts garnicht?! Entwurf nicht gespeichert."

  return
