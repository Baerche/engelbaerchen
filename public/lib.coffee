window.lib = {}
exports = window.lib

window.onerror = (errorMsg, url, lineNumber) ->
    alert JSON.stringify [
        'Hi Progger. window.onerror', errorMsg, url, lineNumber]

window.main = ->
    alert 'Hallo Progger, kein Main! Bitte eins schreiben'


if not window.operamini
    lib.ajax = true
    if location.host != 'localhost'
        document.write """
            <script src="//www.parsecdn.com/js/parse-1.2.18.min.js"></script>
            <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
            <script src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js"></script>
            <script src="gen/keys.js"></script>
            <script src="lib-js.js"></script>
        """
    else
        document.write """
            <script src="../local-libs/parse-1.2.18.min.js"></script>
            <script src="../local-libs/jquery.min.js"></script>
            <script src="../local-libs/underscore-min.js"></script>
            <script src="gen/keys.js"></script>
            <script src="lib-js.js"></script>
        """
    log = (o) ->
        console.log o
        $ '#log'
        .append "#{if o then o.toString() else o}\n"
        o
    ulog = (o) ->
        log o
        $ '#ulog'
        .text "#{if o then o.toString() else o}\n"
        o
else
    lib.ajax = false
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
    #if true
        document.getElementById('realThing').innerHTML = """
            <hr>
            <h2><a href='.'">
            Diese Funktion braucht einen grossen Browser.<br>
            Zurück
            </a></h2>
        """
        return true
    return false

