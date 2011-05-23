
class Projectile extends Mobject
    constructor: (x, y, @v_x, @v_y) ->
        super x, y
    draw: (context, dist, scan) ->
        context.strokeStyle = 'red'
        context.strokeRect(@x - scan, dist - @y - 5, 5, 5)
    update: () ->
        @x += @v_x
        @y += @v_y

window.Projectile = Projectile
