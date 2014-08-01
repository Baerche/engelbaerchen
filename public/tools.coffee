window.writeBearmarklet = ->
    raw = """javascript:(function(){
        var s=document.createElement("script");
        s.src="//#{location.host}/gen/bearmarklet.js";
        document.body.appendChild(s);
        })()
    """
    bearmarklet = encodeURI raw.replace('\n',' ')
    stableRaw = """
        javascript:(function() {
          var h;

          h = "https://#{location.host}/add_bearmark?url=" + (encodeURIComponent(location.href)) + "&title=" + (encodeURIComponent(document.title));

          location.href = h;

        })()
    """
    stable = encodeURI stableRaw.replace '\n',' '
    document.write """
        <p>Zum Draufziehen: <a href="#{_.escape stable}">Bärmarklet001@#{location.host}</a>
        <p>Zum Copypasten:
        <textarea rows="11" class="bearmarklet">#{_.escape stable}</textarea><p>
        <p>Source:
        <textarea rows="11" class="bearmarklet">#{_.escape stableRaw}</textarea><p>
    """

isDev = ->
    location.host.match(/^dev-/)

