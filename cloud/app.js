// These two lines are required to initialize Express in Cloud Code.
var express = require('express');
var app = express();
var parseExpressHttpsRedirect = require('parse-express-https-redirect');
var parseExpressCookieSession = require('parse-express-cookie-session');
var fs = require('fs');
var lib = require('cloud/gen/lib');

var keys = JSON.parse(fs.readFileSync('cloud/keys.json.js'));
keys = keys.Mock;
var initkeys = '"' + keys.applicationId + '", "' + keys.javascriptKey + '"';

// bookmarklet gebaut mit 
// bearmarklet-url: 
var bearmarklet = "javascript:(function()%7Bfunction%20callback()%7B%2F**%2F%7Dvar%20s%3Ddocument.createElement(%22script%22)%3Bs.src%3D%22%2F%2Fengelbaerchen.parseapp.com%2Fgen%2Fbearmarklet.js%22%3Bif(s.addEventListener)%7Bs.addEventListener(%22load%22%2Ccallback%2Cfalse)%7Delse%20if(s.readyState)%7Bs.onreadystatechange%3Dcallback%7Ddocument.body.appendChild(s)%3B%7D)()";

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
                res.render('logged-in.ejs', {
                    username: u.getUsername(),
                    initkeys: initkeys,
                    json: JSON.stringify(["nix"], null, 1),
                    entwurf: u.get('entwurf'),
                    bookmarks: u.get('bookmarks'),
                    bearmarklet: bearmarklet
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
        res.render('meldung.ejs', {
            message: 'Du bist nicht eingeloggt.'
        });
    }
});

app.post('/login', function (req, res) {
    if (req.body.bekannt) {
        Parse.User.logIn(req.body.username, req.body.password)
            .then(function () {
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
        });
    }
});
app.post('/post_entwurf', function (req, res) {
    var u = Parse.User.current();
    if (Parse.User.current()) {
        u = u.fetch()
            .then(function (u) {
                u.set('entwurf', req.body.entwurf);
                return u.save();
            })
            .then(function () {
                res.redirect('/');
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