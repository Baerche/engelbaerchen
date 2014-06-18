window.lib = {}
lib.ajax = window.useAjax

if true
    window.onerror = (errorMsg, url, lineNumber, error) ->
        console.log error
        alert JSON.stringify [
            'Hi Progger. window.onerror', errorMsg, url, lineNumber]
        false

window.main = ->
    alert 'Hallo Progger, kein Main! Bitte eins schreiben'

if lib.ajax
    if not location.host.match /localhost|127\.0\.0\.1/
        document.write """
            <script src="//www.parsecdn.com/js/parse-1.2.18.min.js"></script>
            <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
            <script src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js"></script>
        """
    else
        document.write """
            <script src="../local-libs/parse-1.2.18.min.js"></script>
            <script src="../local-libs/jquery.min.js"></script>
            <script src="../local-libs/underscore-min.js"></script>
        """
        
    window.require = (s) ->
        t = 'cloud/gen/server-lib': 'lib', 'underscore': '_'
        f = t[s]
        window[f]

    document.write """
         <script src="x/ejs_production.js"></script>
         <script src="gen/keys.js"></script>
        <script src="lib-js.js"></script>
        <script>
            window.exports = {}
        </script>
        <script src="mix/gen/mix-lib.js"></script>
        <script>
            window.mix = window.exports
        </script>
    """
    log = (o) ->
        console.log o
        $ '#log'
        .append "#{_.escape if o then o.toString() else o}\n"
        o
    ulog = (o) ->
        log o
        $ '#ulog'
        .text "#{_.escape if o then  o.toString() else o}\n"
        o
else
    log = (o) -> o
    ulog = (o) -> o

lib.log = log
lib.ulog = ulog

window.logout = () ->
    if not lib.ajax then return true
    log 'logging out ajax'
    Parse.User.logOut()
    true

lib.keinGrosserBrowserDannZurueck = ->
    if (not lib.ajax) or (not lib.isContentEditable())
        document.getElementById('realThing').innerHTML = """
            <hr>
            <h2><a href='.'">
            Diese Funktion braucht einen grossen Browser.<br>
            Zurück
            </a></h2>
        """
        return true
    return false

#
# für mix
#

lib.clientSide = true

lib.redirect = (url) ->
    location.href = url

lib.render = (tmpl, data) ->
    $ 'body'
    .html "<h1>Moment</h1>"
    html = new EJS({url: 'views/mix/' + tmpl}).render(data);
    $ 'body'
    .html html
    window.main(true)


lib.gets = {}
lib.posts = {}

lib.defineGet = (path, fun, ajax) ->
    lib.gets[path] = fun

lib.definePost = (path, fun, ajax) ->
    lib.posts[path] = fun

lib.appPrefix = "Mix-"

# zu konvertieren

