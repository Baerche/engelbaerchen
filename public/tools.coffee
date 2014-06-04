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
        <h2>Das
        <a href="#{bearmarklet}">deBärmarklet@#{location.host}</a> &lt;- auf bookmarkleiste ziehen</h2><p>
        Oder dies in die addresse eines lesezeichens kopieren:
        <textarea rows="6" class="bearmarklet">#{bearmarklet}</textarea><p>
        In ruhe lassen, zeigt Javascriptern was dann passiert:
        <textarea rows="6" class="bearmarklet">#{_.escape raw}</textarea><p>
        <a href="gen/bearmarklet.js">Und was danach passiert.</a>
        <hr><iframe src="gen/bearmarklet.js" style="width:100%; height:13em"></iframe>
        Oder direkt: <a href="#{_.escape stable}">Bärmarklet001@#{location.host}</a>
        <textarea rows="11" class="bearmarklet">#{_.escape stableRaw}</textarea><p>
        <textarea rows="11" class="bearmarklet">#{_.escape stable}</textarea><p>
    """

isDev = ->
    location.host.match(/^dev-/)

