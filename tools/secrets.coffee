fs = require 'fs'
appname = 'Mock'
secrets = '../secrets'
#secrets = 'secrets'

keys = JSON.parse fs.readFileSync secrets + '/keys.json'
template = JSON.parse fs.readFileSync 'config/in-global.json'
template.applications[appname].applicationId = keys[appname].applicationId
template.applications[appname].masterKey = keys[appname].masterKey
console.log JSON.stringify template,null,1
fs.writeFileSync secrets + '/global.json', JSON.stringify template

console.log """
mkdir -p #{ secrets }
cat >#{ secrets }/keys.json <<KEYS
#{ fs.readFileSync secrets + '/keys.json' }
KEYS
"""
