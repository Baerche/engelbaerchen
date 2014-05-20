window.writeBearmarklet = ->
    raw = """javascript:(function(){
        var s=document.createElement("script");
        s.src="//#{location.host}/gen/bearmarklet.js";
        document.body.appendChild(s);
        })()
    """
    bearmarklet = encodeURI raw.replace('\n',' ')

    document.write """
        <h2>Das
        <a href="#{bearmarklet}">Bärmarklet@#{location.host}</a> &lt;- auf bookmarkleiste ziehen</h2><p>
        Oder dies in die addresse eines lesezeichens kopieren:
        <textarea rows="6" class="bearmarklet">#{bearmarklet}</textarea><p>
        In ruhe lassen, zeigt Javascriptern was dann passiert:
        <textarea rows="6" class="bearmarklet">#{_.escape raw}</textarea><p>
        <a href="//#{location.host}/gen/bearmarklet.js">Und was danach passiert.</a>
        <hr><iframe src="//#{location.host}/gen/bearmarklet.js" style="width:100%; height:13em"></iframe>
    """

isDev = ->
    location.host.match(/^dev-/)

