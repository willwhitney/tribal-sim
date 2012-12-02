window.distance = (person1, person2) ->
  person1.position.distance person2.position
  
window.vector = (person1, person2) ->
  person1.position.vector_to person2.position