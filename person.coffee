# TODO
# fix locality of behavior
# fix drift
# further reduce garbage collection to enable larger sims

class Person
  @speed_base = 0.1
  @acceleration_base = 0.0001
  @perception_distance = 500
  @friction = 0.00001
  @wind = 0.000005
  
  constructor: (x, y) ->
    @position = new window.Vector(x, y)
    @aggression = Math.random()
    @velocity =  new window.Vector((Math.random() - 0.5) / 4, (Math.random() - 0.5) / 4) # new window.Vector(0, 0)
    @living_color = '000000'
    @dead = false
    @desire = new window.Vector(0, 0)
    @speed = Person.speed_base + (Math.random()  - 0.5) * 2 * Person.speed_base / 10 # random within 10% of base

    # @personality = Math.random()
    # @awareness = Math.random()
    # @relations = []

  next_position: (progress) =>
    @desire.x = @desire.y = 0
    relationship = new window.Vector(0, 0)

    # For each valid person in range, calculate your relationship 
    # and add it to your desire for this timestep
    for other, index in window.world.people
      if other != this and not other.dead and @position.distance(other.position) < Person.perception_distance
          
        [relationship.x, relationship.y] = @position.vector_to(other.position).values()
        mag = relationship.magnitude()

        # run toward the weaker, away from the stronger
        relationship.scale_in_place (@aggression + .05 - other.aggression)

        # the strength of a desire is inverse with distance
        relationship.scale_in_place (1 / Math.pow(mag, 2))

        # scale it to be approximately [0 - 1]
        relationship.scale_in_place (Person.perception_distance)

        # add it to our current desire
        @desire.plus_in_place relationship
  
    # multiply by base acceleration
    @desire.scale_in_place Person.acceleration_base

    # acceleration is the desired acceleration minus friction
    acceleration = @desire.plus @velocity.scale(-1 * Person.friction * progress)

    # add some "wind" from the walls to the middle
    # prevents edges from interfering as much
    acceleration.x += (window.painter.width / 2 - @position.x) * Person.wind
    acceleration.y += (window.painter.height / 2 - @position.y) * Person.wind

    # multiply by elapsed time
    acceleration.scale_in_place progress

    # update the velocity, capped to Person.speed_base
    @velocity.plus_in_place acceleration
    mag = @velocity.magnitude()
    if mag > @speed
      @velocity.scale_in_place (@speed / mag)

    # update position
    @position.plus_in_place @velocity.scale(progress)

    # bounce them off the walls
    within_x = 10 < @position.x < window.painter.width - 10
    if not within_x
      @velocity.x = -0.9 * @velocity.x

    within_y = 10 < @position.y < window.painter.height - 10
    if not within_y
      @velocity.y = -0.9 * @velocity.y

    # force position to be within the walls
    @position.x = Math.max(Math.min(@position.x, window.painter.width - 10), 10)
    @position.y = Math.max(Math.min(@position.y, window.painter.height - 10), 10)
    
  
  color: () =>
    if @dead
      return 'ff0000'
    else return @living_color
  
  # aggress: (progress) =>
  #   for other in window.painter.people
  #     if other != this and not other.dead
  #       if window.distance(this, other) < 7
  #         if @aggression > Math.random() * 10 * Person.scale * progress
  #           other.dead = true
  #           console.log "fatality"
  #           # @aggression += @aggression / 10
  #           return
  
    
window.Person = Person