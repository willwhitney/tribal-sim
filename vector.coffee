class Vector
  @x_options = undefined
  @y_options = undefined
  @options = []
  constructor: (@x, @y) ->
    
  values: () =>
    [@x, @y]

  magnitude: () =>
   Math.pow(Math.pow(@x, 2) + Math.pow(@y, 2) , 1/2)
   
  direction: () =>
    mag = this.magnitude()
    if mag == 0
      return this
    else
      return this.scale(1 / mag)
  
  distance: (other) =>
    # Math.pow( Math.pow(@x - other.x, 2) + Math.pow(@y - other.y, 2) , 1/2 )
    @vector_to(other).magnitude()
    
  vector_to: (other) =>
    new Vector(other.x - @x, other.y - @y)
    ### world wrap code
    Vector.x_options ||= [-1 * window.painter.width, 0, window.painter.width]
    Vector.y_options ||= [-1 * window.painter.height, 0, window.painter.height]
    i = 0
    for x_opt in Vector.x_options
      for y_opt in Vector.y_options
        if Vector.options.length > i + 1
          Vector.options[i].x = other.x + x_opt - @x
          Vector.options[i].y = other.y + y_opt - @y
        else
          Vector.options.push new Vector(window.painter, other.x + x_opt - @x, other.y + y_opt - @y)
        i++

    best = Vector.options[0]
    for opt, index in Vector.options
      if index < i - 1
        if opt.magnitude() < best.magnitude()
          best = opt
        
    Vector.options.length = 0

    return best
    ###

  plus: (other) =>
    new Vector(@x + other.x, @y + other.y)
    
  plus_in_place: (other) =>
    @x = @x + other.x
    @y = @y + other.y
    return this
    
  scale: (scalar) =>
    new Vector(@x * scalar, @y * scalar)
    
  scale_in_place: (scalar) =>
    @x = @x * scalar
    @y = @y * scalar
    return this
    
  copy: () =>
    new Vector(@x, @y)

window.Vector = Vector
