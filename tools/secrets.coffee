#!coffee
fs = require 'fs'
appname = 'Mock'
#secrets = '../secrets'
secrets = 'secrets'

insertKeys = (globalFile, allKeys) ->
	inGlobal = JSON.parse fs.readFileSync globalFile
	inKeys = inGlobal.applications
	for app of allKeys
		for k of keys = allKeys[app]
			inKeys[app][k] = allKeys[app][k]
	inGlobal			

try
	keys = JSON.parse fs.readFileSync secrets + '/keys.json'
catch e
	keys = 
		Dummy: 
			#secret
			masterKey: "placeholder"
			cookieSigningSecret: "placeholder"
			#public
			applicationId: "placeholder"
			"javascriptKey": "placeholder"

ko = insertKeys 'config/in-global.json', keys
ko = JSON.stringify ko, null, 1
fs.writeFileSync secrets + '/global.json', ko
fs.writeFileSync secrets + '/gen/global.js', 'exports.content = ' + ko

console.log """
mkdir -p #{ secrets }
cat >#{ secrets }/keys.json <<KEYS
#{ fs.readFileSync secrets + '/keys.json' }KEYS
"""



