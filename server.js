var app, colors, express, fs, http, path, port;

express = require('express');

colors = require('colors');

http = require('http');

path = require('path');

fs = require('fs');

port = 4000;

app = express();

app.configure(function() {
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  app.use(express.session({
    secret: 'ozclient',
    cookie: {
      maxAge: null
    }
  }));
  app.use(app.router);
  return app.use(express["static"](__dirname + '/'));
});

app.get('/', function(req, res) {
  return fs.readFile('index.html', function(err, data) {
    if (err) {
      res.send('error!');
    }
    res.set({
      'Vary': 'Accept-Encoding',
      'Content-Type': 'text/html'
    });
    return res.send(data);
  });
});

app.listen(port, function() {
  return console.log("server work at ".grey + ("http://localhost:" + (port.toString())).blue);
});
