fs = require 'fs'
ejs = require 'ejs'

console.log process.argv
process.argv.splice(0,2)
console.log process.argv
json = {}
for i in process.argv
    k = i.replace 'public/views/',''
    t = '' + fs.readFileSync i
    json[k] = t
console.log json

compile_ejs = () ->
    for i in templates
        templates[i] = ejs.compile templates[i]
        
#o = "templates = #{JSON.stringify json};\n(#{compile_ejs.toString()})()"
o = "templates = #{JSON.stringify json};"
console.log o
fs.writeFileSync "public/gen/templates.js", o

