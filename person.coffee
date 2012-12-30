# TODO
# fix locality of behavior
# fix drift
# further reduce garbage collection to enable larger sims

class Person
  @scale = 5 / 50
  
  constructor: (@painter, x, y) ->
    @position = new window.Vector(@painter, x, y)
    @personality = Math.random()
    @aggression = Math.random()
    @drift =  new window.Vector(@painter, (Math.random() - 0.5) / 4, (Math.random() - 0.5) / 4) # new window.Vector(@painter, 0, 0)
    @col = '000000'
    @dead = false
    # @awareness = Math.random()
    # @relations = []
    @desire = new window.Vector(@painter, 0, 0)
    
  next_position: (progress) =>
    # @desire ||= new window.Vector(@painter, 0, 0)
    @desire.x = 0
    @desire.y = 0
    for other, index in @painter.people
      if other != this and not other.dead #and @awareness > Math.random()
        if @position.distance(other.position) < 400
          relation = @position.vector_to(other.position).copy()
          mag = relation.magnitude()
          relation.scale_in_place 1 / (mag + 0.0001)

          # locality
          relation.scale_in_place 40 / Math.max(mag, 35)
          # console.log 40 / Math.max(mag, 35)
          
          # personality
          # relation.scale_in_place -1 * Math.abs(@personality - other.personality)
          
          relation.scale_in_place @aggression + .05 - other.aggression
          @desire.plus_in_place relation
        
    
      
    scale = Person.scale * progress
    @desire.plus_in_place @drift
    @desire.scale_in_place scale
    
    
    @position.plus_in_place @desire
    @position.x = (@position.x + @painter.width) % @painter.width
    @position.y = (@position.y + @painter.height) % @painter.height
  
    
  
  color: () =>
    if @dead
      return 'ff0000'
    else return @col
  
  aggress: (progress) =>
    for other in @painter.people
      if other != this and not other.dead
        if window.distance(this, other) < 7
          if @aggression > Math.random() * 10 * Person.scale * progress
            other.dead = true
            console.log "fatality"
            # @aggression += @aggression / 10
            return
  
    
window.Person = Person