class Person
  @desire = undefined
  @scale = 1 / 50
  
  constructor: (@painter, x, y) ->
    @position = new window.Vector(@painter, x, y)
    @charisma = Math.random() * 1.1
    @aggression = Math.random()
    @drift = new window.Vector(@painter, Math.random() / 10, Math.random() / 10)
    @col = '000000'  # Math.floor(Math.random()*16777215).toString(16);
    @dead = false
    @awareness = Math.random()
    
  next_position: (progress) =>
    Person.desire ||= new window.Vector(@painter, 0, 0)
    Person.desire.x = 0
    Person.desire.y = 0
    for other in @painter.people
      if other != this and not other.dead #and @awareness > Math.random()
        if @position.distance(other.position) < 300
          relation = @position.vector_to(other.position).scale(1 / @position.distance(other.position)+ 0.0001)
          relation = relation.scale(@aggression + .1 - other.aggression)
          Person.desire = Person.desire.plus(relation)
        
    
      
    scale = Person.scale * progress
    # console.log desire.scale(scale)
    @position = @position.plus(Person.desire.scale(scale).plus(@drift))
    
    # @position.x = Math.max(Math.min(@position.x, @painter.width), 0)
    # @position.y = Math.max(Math.min(@position.y, @painter.height), 0)
    @position.x = (@position.x + @painter.width) % @painter.width
    @position.y = (@position.y + @painter.height) % @painter.height
    # console.log @position.x
    # console.log @position.y
    
  color: () =>
    if @dead
      return 'ff0000'
    else return @col
  
  aggress: (progress) =>
    for other in @painter.people
      if other != this and not other.dead
        if window.distance(this, other) < 5
          if @aggression > Math.random() * 10 * Person.scale * progress
            other.dead = true
            console.log "fatality"
            return
  
    
window.Person = Person