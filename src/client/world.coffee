
class World
    constructor: (canvas_elem) ->
        @canvas_elem = $(canvas_elem)
        @context = @canvas_elem.getContext('2d')
        @entities = []

window.World = World
