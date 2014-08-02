_ = require 'underscore'
config = require('cloud/gen/global').content
debug = require('cloud/mix/gen/debug-config')

lib = exports

# Parse.applicationId missing while deploy
appKey = "XvfIKW98ROlBjl9RHwZYqRwnOsUbI87MTlbUNY6L" #Dev

lib.listUsers = (users) ->
    [ users.length,
        ( [u.get('username'), u.get('entwurf')] for u in users )
    ]
    
lib.addBearmark = (user, query) ->
    b = user.get 'bookmarks'
    u = _.escape query.url
    u = """<a href="#{u}">[#{_.escape query.title} | #{u}]</a><br>\n"""
    b = u + b
    user.set 'bookmarks', b
   
appFromKey = (key,apps) ->
    for i of apps
        if apps[i].applicationId == key
            return [i, apps[i]]
    return null

lib.appName = () ->
    a = appFromKey appKey, config.applications
    a[0]

lib.appKeys = () ->
    a = appFromKey appKey, config.applications
    a[1]

#
# für mix
#

lib.clientSide = false

lib.appPrefix = "#{if lib.appName()=='Dev' then 'Dev-' else ''}"

lib.defineGet = (path, fun, ajax) ->
    lib.app.get path, (req, res) ->
        lib.ajax = debug.NOT_SIM_OMI and ! req.headers["user-agent"].match /Opera Mini/
        if lib.ajax
            res.render "ajax", 
                path: path
                ajax: ajax
        else
            lib.res = res
            fun req.query, res

lib.definePost = (path, fun, ajax) ->
    lib.app.post path, (req, res) ->
        lib.ajax = debug.NOT_SIM_OMI and ! req.headers["user-agent"].match /Opera Mini/
        if lib.ajax
            res.render "ajax", 
                path: path
                ajax: ajax
        else
            lib.res = res
            fun req.body, res

lib.ejsEsc = (s) ->
    s

#
#app-handler in coffeescript
#

lib.register = (app) ->
    lib.app = app
    app.get "/add_bearmark", (req, res) ->
        o = 
            title: req.query.title
            url: req.query.url
            referer: req.headers.referer
            open: '{{'
            close: '}}'
        render = () ->
            o.log = lib.logged.join ''
            res.render "bestaetige-bearmark.ejs", o
            return
        u = Parse.User.current()
        if u
            u.fetch()
            .then (u) ->
                log "Hallo #{u.get 'username'}, du bist auf server eingeloggt"
                render()
            , (e) -> 
                log e
                render()
        else
            log 'Nicht auf server eingeloggt'
            render()

#
#logging
#

lib.logged = []

lib.log = (o) ->
    console.log o
    lib.logged.push "svr: #{o}\n"
        
lib.ulog = lib.log

log = lib.log
ulog = lib.ulog
