keys = require '../cloud/gen/global.js'
.content.applications
#console.log process.argv; console.log keys
app = process.argv[2]
key = process.argv[3]
console.log keys[app][key]
