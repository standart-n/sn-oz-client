
express = 					require('express')
colors = 					require('colors')
http = 						require('http')
path = 						require('path')
fs = 						require('fs')

port = 						4000

app = express()

app.configure ->

	app.use express.logger 'dev'

	app.use express.bodyParser()

	app.use express.methodOverride()

	app.use express.cookieParser()

	app.use express.session
		secret:	'ozclient'
		cookie:
			maxAge:	null

	app.use app.router

	app.use express.static __dirname + '/'

	# app.use express.directory __dirname + '/'


app.get '/', (req, res) ->
	fs.readFile 'index.html', (err, data) ->
		res.send 'error!' if err
		res.set 
			'Vary':				'Accept-Encoding'
			'Content-Type':		'text/html'

		res.send data


# server = http.createServer(app)

app.listen port, () ->
	console.log "server work at ".grey + "http://localhost: ".grey + port.toString().blue

