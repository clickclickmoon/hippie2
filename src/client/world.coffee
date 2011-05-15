
class World
    constructor: (@name) ->
        @clients = []
        @socket = new io.Socket()
        @socket.on 'connect', () =>
            @socket.send { cmd: 'logon', username: @name }
        @socket.on 'message', (data) =>
            switch data.cmd
                when 'logon'
                    @pos = data.pos
                    @uid = data.uid
        @socket.connect()

    
window.World = World