lib = require 'cloud/gen/server-lib'
_ = require 'underscore'
debug = require ('cloud/mix/gen/debug-config')
mix = exports

log = lib.log
ulog = lib.ulog

mix.register = (run) ->

    lib.defineGet '/', mix.index, 
        title: "Index"
        mainScript: "gen/logged-in.js"
    lib.definePost '/', mix.postEntwurf, 
        title: "Index"
        mainScript: "gen/logged-in.js"
        
    lib.defineGet '/debug.html', mix.debug, 
        mainScript: "gen/nop.js"
    lib.definePost '/debug', mix.postDebug, 
        mainScript: "gen/nop.js"
        
    lib.definePost '/bearmark_eintragen', mix.postBearmark

    if run
        $ ->
            lib.trap(lib.gets[run])({}, new lib.AjaxRes())

mix.debug = (req, res, msg) ->
    lo = debug: debug
    render = () -> 
        res.render "mix/debug.ejs", 
            msg: JSON.stringify lo, null, 4
            open: '{{'
            close: '}}'
    render()
        
mix.postDebug = (req, res) ->
    mix.debug req, res, "dummy-done"
    
mix.index = (req, res, msg) ->
  u = Parse.User.current()
  if u
    u.fetch().then ((u) ->
      json = "Es wird nichts untersucht"
      json = JSON.stringify {ajax: lib.ajax, clientSide: lib.clientSide}, null, 1
      #json = JSON.stringify req.headers, null, 1
      args = 
        username: lib.ejsEsc u.getUsername()
        json: lib.ejsEsc json
        entwurf: lib.ejsEsc u.get("entwurf")
        bookmarks: u.get("bookmarks")
        msg: lib.ejsEsc if msg then msg else ""
        pref: lib.ejsEsc lib.appPrefix
      res.render "mix/logged-in.ejs", args
      if lib.clientSide
        $ ".bookmarks"
        .html args.bookmarks
      true
    ), (error) ->
      console.error error
      res.render "mix/meldung.ejs",
        message: "Hier drin ging was kaputt." + (lib.clientSide and "\nBrowserinfo: " + navigator.userAgent or '')
      return

  else
    res.redirect "login.html"
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

mix.addBearmark = (user, query) ->
    b = user.get 'bookmarks'
    u = _.escape query.url
    u = """<a href="#{u}">[#{_.escape query.title} | #{u}]</a><br>\n"""
    b = u + b
    user.set 'bookmarks', b

mix.postBearmark = (req, res) ->
    did = {}
    render = () ->
        if not lib.clientSide
            res.render "mix/meldung.ejs",
                message: lib.logged.join ''
    post = () ->
        
    ulog "Posting"
    log JSON.stringify req
    u = Parse.User.current()
    if u
        u.fetch()
        .then (u) ->
            log "Immer noch eingeloggt als #{u.get 'username'}, in form #{req.user}"
            did.login = true
            u
        .then (u) ->
            mix.addBearmark u, req
            u.save()
        .then (u) ->
            res.redirect '/'
        , (e) -> 
            log e
            render()
    else
        log 'Nicht mehr eingeloggt'
        render()
    
    
