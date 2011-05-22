
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
        
        $(document).addEvent 'keydown', (event) =>
            switch event.key
                when 'k'
                    console.log @scan
        
        do_draw = () => @draw()
        do_update = () => @update()
        do_camera = () =>
            [old_dist, old_scan] = [@dist, @scan]
            @scan -= 10 if @player.x - old_scan < 100 and old_scan > 0
            @scan += 10 if old_scan + @width - @player.x  < 150 and old_scan < 800
            @dist += 0.1
            @player.y = old_dist + 100 if (@height - ((old_dist + @height) - @player.y)) < 100
            @player.y = (old_dist + @height) - 150 if ((old_dist + @height) - @player.y) < 150
        setInterval do_draw, 30
        setInterval do_update
        setInterval do_camera
            
    draw: () ->
        @context.clearRect(0, 0, @width, @height)
        e.draw(@context, @dist + @height, @scan) for e in @entitys
    
    update: () ->
        m.update() for m in @entitys when m.update?
        
    set_size: (@girth, @length) -> true

window.World = World
