m = () ->
    s='coffee'
    z s
    document.write s

z = (o) ->
    console.log 'Zombie: ' + o

m()