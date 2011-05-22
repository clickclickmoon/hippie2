
class Entity
    constructor: (@x, @y) -> true
    draw: (context, dist, scan) ->
        context.fillStyle = 'black'
        context.strokeRect(@x - scan, dist - @y - 50, 50, 50)

window.Entity = Entity
