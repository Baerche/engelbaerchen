Browser = require 'zombie'
assert = require 'assert'

u = 'http://engelbaerchen.parseapp.com'

Browser.visit u, (e, browser) ->
    console.log JSON.stringify [ e, browser.success, browser.statusCode, browser.errors ]
    console.log browser.html()
    console.log browser.text()
