class World
  constructor: (people_count) ->
    @people = []
    @time = undefined

    for i in [0... people_count]
      @people.push new window.Person( 
          Math.random() * window.painter.width, 
          Math.random() * window.painter.height
        )

  update: (timestamp) ->
    # console.log "update received in world"
    @time ?= timestamp

    progress = timestamp - @time
    @time = timestamp

    for person in @people when not person.dead
      person.next_position(progress)

    for a in @people when not a.dead
      for b in @people when not b.dead
        if a != b and a.position.distance(b.position) < 5
          a_roll = Math.random() * a.aggression
          b_roll = Math.random() * b.aggression
          if a_roll >= b_roll
            b.dead = true
          else
            a.dead = true


window.World = World