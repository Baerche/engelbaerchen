if this.exports
    debug = exports
else
    window.debug = debug = {}

debug.notOmi = (userAgent) ->    

    #return true # debug

    return ! userAgent.match /Opera Mini/

