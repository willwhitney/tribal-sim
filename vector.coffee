class Vector
  @x_options = undefined
  @y_options = undefined
  @options = []
  constructor: (@painter, @x, @y) ->
    
  magnitude: () =>
   Math.pow( Math.pow(@x, 2) + Math.pow(@y, 2) , 1/2)
   
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
    Vector.x_options ||= [-1 * @painter.width, 0, @painter.width]
    Vector.y_options ||= [-1 * @painter.height, 0, @painter.height]
    for x_opt in Vector.x_options
      for y_opt in Vector.y_options
        Vector.options.push new Vector(@painter, other.x + x_opt - @x, other.y + y_opt - @y)
    best = Vector.options[0]
    for opt in Vector.options
      if opt.magnitude() < best.magnitude()
        best = opt
        
    Vector.options.length = 0
    return best
    # new Vector(other.x - @x, other.y - @y)
    
  plus: (other) =>
    new Vector(@painter, @x + other.x, @y + other.y)
    
  scale: (scalar) =>
    new Vector(@painter, @x * scalar, @y * scalar)

window.Vector = Vector
