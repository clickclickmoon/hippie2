
class World
    constructor: (canvas_elem) ->
        @canvas_elem = $(canvas_elem)
        @width = @canvas_elem.width
        @height = @canvas_elem.height
        @context = @canvas_elem.getContext('2d')
        @entitys = []
        @dist = 0
        @scan = 400
        @entitys.push new Entity 0, 0
        @entitys.push new Entity 1550, 0
        @player = new Player()
        @entitys.push @player
        @firing = no
        
        $(document).addEvent 'keydown', (event) =>
            switch event.key
                when 'space' then @firing = yes
        
        $(document).addEvent 'keyup', (event) =>
            switch event.key
                when 'space' then @firing = no
        
        do_draw = () => @draw()
        do_update = () => @update()
        setInterval do_draw, 30
        setInterval do_update
            
    draw: () ->
        @entitys.push new Projectile @player.x, @player.y, 0, 5 if @firing
        @context.clearRect(0, 0, @width, @height)
        e.draw(@context, @dist + @height, @scan) for e in @entitys
        @camera()
        @draw_hud()
    
    update: () ->
        m.update() for m in @entitys when m.update?
        @player.hp -= 0.1 unless @player.hp <= 0
        @player.soft_hp -= 0.01 unless @player.soft_hp <= 0
    
    camera: () ->
        [old_dist, old_scan] = [@dist, @scan]
        @scan -= 10 if @player.x - old_scan < 160 and old_scan > 0
        @scan += 10 if old_scan + @width - @player.x  < 210 and old_scan < 800
        @dist += 0.1
        @player.y = old_dist + 50 if (@height - ((old_dist + @height) - @player.y)) < 50
        @player.y = (old_dist + @height) - 100 if ((old_dist + @height) - @player.y) < 100
    
    draw_hud: () ->
        @context.fillStyle = '#FFFD75'
        percent_soft = 200 * @player.soft_hp / @player.max_hp
        @context.fillRect(@width - 30 - 5, @height - percent_soft - 10, 25, percent_soft)
        
        @context.fillStyle = '#ED2D2D'
        percent_hp = 200 * @player.hp / @player.max_hp
        @context.fillRect(@width - 30 - 5, @height - percent_hp - 10, 25, percent_hp)
        
        @context.lineWidth = 3
        @context.lineJoin = 'round'
        @context.strokeStyle = 'black'
        @context.strokeRect(@width - 35, @height - 210, 25, 200)
        
        @context.lineWidth = 2
        @context.strokeRect(@width - 35, 10, 25, 25)
        
        @context.lineWidth = 3
        @context.moveTo(60, 0)
        @context.lineTo(60, @height)
        @context.stroke()
    
    set_size: (@girth, @length) -> true

window.World = World
