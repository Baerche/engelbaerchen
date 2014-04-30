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

config = insertKeys 'config/in-global.json', keys
ko = JSON.stringify config, null, 1
fs.writeFileSync secrets + '/global.json', ko
fs.writeFileSync secrets + '/gen/global.js', 'exports.content = ' + ko

k = config.applications['Dev']
init = """
	Parse.initialize("#{k.applicationId}", "#{k.javascriptKey}");
"""
fs.writeFileSync 'public/gen/keys.js', init


console.log """
mkdir -p #{ secrets }
cat >#{ secrets }/keys.json <<KEYS
#{ fs.readFileSync secrets + '/keys.json' }KEYS
"""



