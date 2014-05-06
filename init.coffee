$ ->
  window.painter = new window.Painter()

  # World takes a number of people.
  window.world = new window.World(100)
  
  
  window.webkitRequestAnimationFrame window.painter.update, window.painter.canvas