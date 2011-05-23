
class Entity
    constructor: (@x, @y) -> true
    draw: (context, dist, scan) ->
        context.strokeStyle = 'black'
        context.strokeRect(@x - scan, dist - @y - 50, 50, 50)

window.Entity = Entity
