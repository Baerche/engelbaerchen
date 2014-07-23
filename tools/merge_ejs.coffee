fs = require 'fs'
console.log process.argv
process.argv.splice(0,2)
console.log process.argv
json = {}
for i in process.argv
    k = i.replace 'public/views/',''
    json[k] = '' + fs.readFileSync i
console.log json
fs.writeFileSync "public/templates.js", "templates = #{JSON.stringify json}"

