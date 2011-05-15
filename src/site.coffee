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

site.get '/', (req, res) -> res.render 'login', {}
site.get '/game', (req, res) ->
    username = req.param('username', '')
    if username is ''
        res.redirect '/'
    else
        res.render 'game', { username: username }

site.listen 80
console.log 'Express! on port %s', site.address().port

player_list = []

socket.on 'connection', (client) ->
    client.on 'message', (data) ->
        if data.cmd is 'logon'
            console.log "#{data.username} logged in."
            client.send { cmd: 'logon', uid: player_list.length }
            player_list.push { name: data.username, port: client }
