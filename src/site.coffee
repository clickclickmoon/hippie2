express = require 'express'
site = express.createServer()
#io = require 'socket.io'

#socket = io.listen site

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

site.listen 8032
console.log 'Express! on port %s', site.address().port

player_list = []

###
socket.on 'connection', (client) ->
    client.on 'message', (data) ->
        if data.cmd is 'logon'
            console.log "#{data.username} logged in."
            client.send { cmd: 'logon', uid: player_list.length, pos: { x: 0, y: 0 } }
            player_list.push { name: data.username, port: client }
###
