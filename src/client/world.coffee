
class World
    constructor: (canvas_elem) ->
        @canvas_elem = $(canvas_elem)
        @width = @canvas_elem.width
        @height = @canvas_elem.height
        @context = @canvas_elem.getContext('2d')
        @entitys = []
        @dist = 0
        @scan = 0
        @entitys.push new Entity 0, 0
        @entitys.push new Entity 1550, 0
        
        $(document).addEvent 'keydown', (event) =>
            switch event.key
                when 'left'
                    @scan -= 10 if @scan > 0
                when 'right'
                    @scan += 10 if @scan < @girth - @width
        
        do_draw = () => @draw()
        do_update = () => @update()
        setInterval(do_draw, 30)
        setInterval(do_update)
        
    draw: () ->
        @context.clearRect(0, 0, @width, @height)
        e.draw(@context, @dist + @height, @scan) for e in @entitys
    
    update: () ->
        m.update() for m in @entitys when m.update?
        
    set_size: (@girth, @length) -> true

window.World = World
