
class Player extends Mobject
    constructor: () ->
        super(775, 0)
        
        $(document).addEvent 'keydown', (event) =>
            switch event.key
                when 'left'
                    @x -= 10 if @x > 0
                when 'right'
                    @x += 10 if @x < 1550
                when 'up'
                    @y += 10 if @y < 60000
                when 'down'
                    @y -= 3 if @y > 0
        
    update: () ->
        console.log "something arst"

window.Player = Player
