
class Player extends Mobject
    constructor: () ->
        super 775, 0
        
        @left_down  = no
        @right_down = no
        @up_down    = no
        @down_down  = no  
        
        @hp = 80
        @max_hp = 100
        @soft_hp = 90
        
        $(document).addEvent 'keydown', (event) =>
            switch event.key
                when 'left'  then @left_down  = yes
                when 'right' then @right_down = yes
                when 'up'    then @up_down    = yes
                when 'down'  then @down_down  = yes
        
        $(document).addEvent 'keyup', (event) =>
            switch event.key
                when 'left'  then @left_down  = no
                when 'right' then @right_down = no
                when 'up'    then @up_down    = no
                when 'down'  then @down_down  = no
    
    update: () ->
        @x -= 1.0 if @x > 0     and @left_down is yes
        @x += 1.0 if @x < 1550  and @right_down is yes
        @y += 1.0 if @y < 60000 and @up_down is yes
        @y -= 0.3 if @y > 0     and @down_down is yes
        

window.Player = Player
