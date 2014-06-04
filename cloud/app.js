// These two lines are required to initialize Express in Cloud Code.
var express = require('express');
var app = express();
var parseExpressHttpsRedirect = require('parse-express-https-redirect');
var parseExpressCookieSession = require('parse-express-cookie-session');
var fs = require('fs');
var _ = require('underscore');

var config = require('cloud/gen/global').content;
var lib = require('cloud/gen/lib');

var keys = lib.appKeys();

var bearmarklet = lib.bearmarklet

// Global app configuration section
app.set('views', 'cloud/views'); // Specify the folder to find templates
app.set('view engine', 'ejs'); // Set the template engine
app.use(parseExpressHttpsRedirect()); // Require user to be on HTTPS.
app.use(express.bodyParser()); // Middleware for reading request body
app.use(express.cookieParser(keys.cookieSigningSecret));
app.use(parseExpressCookieSession({
    cookie: {
        maxAge: 3600000
    }
}));

app.get('/', function (req, res) {
    var u = Parse.User.current();
    if (Parse.User.current()) {
        u.fetch()
            .then(function (u) {
                json = 'Es wird nichts untersucht';
                if (u.getUsername() === "admin") {
                	try{
						json = [json, 'auch nicht als admin'];
					} catch (e) {
						json = {error: e};
					}
					json = JSON.stringify(json, null, 4);
				}
                res.render('logged-in.ejs', {
                    username: u.getUsername(),
                    json: json,
                    entwurf: u.get('entwurf'),
                    bookmarks: u.get('bookmarks'),
                    msg: req.query.msg ? req.query.msg : "",
                    pref: lib.appPrefix
                });
                return true;
            }, function (error) {
                console.error(error);
                res.render('meldung.ejs', {
                    message: 'Hier drin ging was kaputt.'
                });
            });
    } else {
        res.redirect('/login.html');
    }
});

app.get('/add_bearmark', function (req, res) {
    var u = Parse.User.current();
    if (Parse.User.current()) {
        u.fetch()
            .then(function (u) {
                lib.addBearmark(u, req.query);
                return u.save();
            }).then(function () {
                res.redirect('/');
            }, function (error) {
                console.error(error);
                res.render('meldung.ejs', {
                    message: 'Hier drin ging was kaputt.'
                });
            });
    } else {
		res.render('add-bearmark-login.ejs', {
			title: req.query.title,
			url: req.query.url
		});
   }
});

app.post('/login', function (req, res) {
    if (req.body.bekannt) {
        Parse.User.logIn(req.body.username, req.body.password)
            .then(function (u) {
				if (req.body.url) {
					lib.addBearmark(u, req.query);
				}
                res.redirect('/');
                return true;
            }, function (u, error) {
                res.render('meldung.ejs', {
                    message: 'So kenne ich dich garnicht? Username, Passwort ok? ;-) '
                });
            });
    } else if (req.body.neu_hier) {
        Parse.User.signUp(req.body.username, req.body.password, {
            ACL: new Parse.ACL()
        })
            .then(function () {
                res.redirect('/');
                return true;
            }, function (error) {
                res.render('meldung.ejs', {
                    message: 'Konnte dir keinen Account machen. Kenne ich dich schon? ' + 'Dann bitte login ;-)'
                });
            });
    } else {
        res.render('meldung.ejs', {
            message: 'Ich geh kaputt! Hihi das kiitzelt!'
            + JSON.stringify(req.body)
        });
    }
});
app.post('/post_entwurf', function (req, res) {
    var u = Parse.User.current();
    if (Parse.User.current()) {
        var msg ="Gespeichert";
        u = u.fetch()
            .then(function (u) {
                if (req.body.Eintragen) {
                    lib.addToBookmarks(u, _.escape(req.body.entwurf));
                    msg += " und eingetragen";
	                u.set('entwurf', '');
                } else {
	                u.set('entwurf', req.body.entwurf);
                }
                return u.save();
            })
            .then(function () {
                res.redirect('/?msg=' + encodeURIComponent(msg));
                return true;
            }, function (u, error) {
                res.render('meldung.ejs', {
                    message: 'Was kaputt. Konnte Entwurf nicht speichern. '
                });
            });
    } else {
        res.render('meldung.ejs', {
            message: 'He dich gibts garnicht?! Entwurf nicht gespeichert.'
        });
    }
});
app.post('/echo', function (req, res) {
    res.render('meldung.ejs', {
        message: 'echo post args: ' + JSON.stringify(req.body, null, 1)
    });
});
app.get('/logout', function (req, res) {
    Parse.User.logOut();
    res.redirect('/');
});

// // Example reading from the request query string of an HTTP get request.
// app.get('/test', function(req, res) {
//   // GET http://example.parseapp.com/test?message=hello
//   res.send(req.query.message);
// });
// // Example reading from the request body of an HTTP post request.
// app.post('/test', function(req, res) {
//   // POST http://example.parseapp.com/test (with request body "message=hello")
//   res.send(req.body.message);
// });
// Attach the Express app to Cloud Code.
app.listen();
