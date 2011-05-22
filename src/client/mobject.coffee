
class Mobject extends Entity
    constructor: (x, y) ->
        super(x, y)
        @velocity = { x: 0, y: 0 }
    update: () ->
        console.log "something arst"

window.Mobject = Mobject
