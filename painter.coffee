class Painter
  constructor: ->
    @canvas = document.getElementById 'canvas'
    @canvas.width  = window.innerWidth - 10;
    @canvas.height = window.innerHeight - 10;
    @width = @canvas.width
    @height = @canvas.height
    @context = @canvas.getContext '2d'

  draw: () =>
    # console.log "Drawing."
    @context.clearRect 0, 0, @canvas.width, @canvas.height
    
    # paint the dead people first so they're underneath the live ones
    for person in window.world.people when person.dead
      @context.fillStyle = '#' + person.color()
      @context.fillRect person.position.x - 1, person.position.y - 1, 3, 3

    # paint the live people
    for person in window.world.people when not person.dead
      @context.fillStyle = '#' + person.color()
      @context.fillRect person.position.x - 1, person.position.y - 1, 3, 3
      
      # @context.font = '8pt Helvetica'
      # @context.fillStyle = 'red'
      # @context.fillText Math.round(person.aggression * 100) / 100, person.position.x - 7, person.position.y - 4
      # @context.fillStyle = 'green'
      # @context.fillText Math.round(person.personality * 100) / 100, person.position.x - 7, person.position.y - 13
      
  update: (timestamp) =>
    # console.log "update received in painter"

    # get the world updated
    window.world.update(timestamp)

    # ask for the next frame
    window.webkitRequestAnimationFrame this.update

    # actually paint
    this.draw()


window.Painter = Painter