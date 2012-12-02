class Painter
  constructor: (people_count) ->
    @width = $('#canvas').width()
    @height = $('#canvas').height()
    @canvas = document.getElementById 'canvas'
    @context = canvas.getContext '2d'
    @people = []
    @time = 0
    
    for i in [0... people_count]
      @people.push new window.Person(this, Math.random() * @width, Math.random() * @height)
    window.people = @people
  
  draw: () =>
    @context.clearRect 0, 0, canvas.width, canvas.height
    
    for person in @people
      @context.fillStyle = '#' + person.color()
      @context.fillRect person.position.x - 1, person.position.y - 1, 3, 3
      
  update: (timestamp) =>
    progress = timestamp - @time
    @time = timestamp
    window.webkitRequestAnimationFrame this.update

    for person in @people when not person.dead
      person.next_position(progress)

    for person in @people when not person.dead
      person.aggress(progress)
      
    this.draw()

$ ->
  
  painter = new Painter 50
  
  window.webkitRequestAnimationFrame painter.update, painter.canvas
