
class World
    constructor: (canvas_elem) ->
        @canvas_elem = $(canvas_elem)
        @width = @canvas_elem.width
        @height = @canvas_elem.height
        @context = @canvas_elem.getContext('2d')
        @entities = []
        @dist = 0
        @scan = 0
        @entities.push new Entity 0, 0
        @entities.push new Entity 1550, 0
        
        $(document).addEvent 'keydown', (event) =>
            switch event.key
                when 'left'
                    @scan += 10
                when 'right'
                    @scan -= 10
        
        setInterval () => @draw()
        
    draw: () ->
        @context.clearRect(0, 0, @width, @height)
        e.draw(@context, @dist + @height, @scan) for e in @entities
    set_size: (@girth, @length) -> true

window.World = World
