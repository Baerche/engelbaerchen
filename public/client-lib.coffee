window.lib = {}
lib.ajax = window.useAjax

if true
    window.onerror = (errorMsg, url, lineNumber, error) ->
        if error then console.log error #dauernull, nur neue browser
        alert JSON.stringify [
            'Hi Progger. Console öffnen und nochmal testen.', errorMsg, url, lineNumber]
        false

lib.trap = (fun) ->
	(args...) ->
		try fun args...
		catch e
			#console.log e # nur desc
			#console.trace() # only functions
			console.log (e.stack) #desc und functions mit source-url (ohne sourcemap)
			debugger
			#alert 'Schau für Teufelchen in console: ' + e
			throw e

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

lib.gets = {}
lib.posts = {}

lib.defineGet = (path, fun, ajax) ->
    lib.gets[path] = fun

lib.definePost = (path, fun, ajax) ->
    lib.posts[path] = fun

lib.appPrefix = "Mix-"

lib.AjaxRes = () ->
	@render = (tmpl, data) ->
		$ 'body'
		.html "<h1>Moment</h1>"
		html = new EJS({url: 'views/' + tmpl}).render(data);
		$ 'body'
		.html html
		window.main(true)
	@redirect = (url) ->
		location.href = url
	@

#testet auch auf ajax, sonst return false für autopost
lib.submitAjax = lib.trap (fun,submitButtonRaw) ->
	if ! lib.ajax then return true
	a = $(submitButtonRaw.form).serializeArray()
	o = {}
	o[submitButtonRaw.name] = submitButtonRaw.value
	for v in a
		o[v.name] = v.value
	#log JSON.stringify o
	fun(o, new lib.AjaxRes())
	return false


# zu konvertieren

