express = require 'express'
site = express.createServer()
io = require 'socket.io'

socket = io.listen site

process.on 'SIGINT', () -> process.exit(5)

site.configure () ->
    site.use express.bodyParser()
    site.use express.static(__dirname + '/public')
    site.set 'views', __dirname + '/views'
    site.set 'view engine', 'jade'
    site.use express.methodOverride()
    site.use express.cookieParser()
    site.use site.router
    site.use express.errorHandler({ dumpExceptions: true, showStack: true })

site.get '/', (req, res) -> res.render 'game', {}

site.listen 80
console.log 'Express! on port %s', site.address().port

socket.on 'connection', (client) ->
    console.log "connected"
    client.send {hello: 'world'}
