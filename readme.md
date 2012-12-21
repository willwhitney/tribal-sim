# Stochastic HTML5 predator-prey sim

To run, simply open `index.html` in a WebKit browser. The CoffeeScript is compiled in the browser.

All results are randomly generated at runtime. 

## What it does

Currently creates a couple dozen `Person` objects, each with a random `aggression` value. On each frame, each `person` will move toward those with aggression lower than theirs, and away from those with aggression higher than theirs.

## To do

### Performance

Doesn't have great performance right now due to garbage collection. Will add in-place Vector operations and temp vectors so there will be ~zero garbage collection required.

### Behavior

Next, they'll start to 'like' each other, and cluster together in wandering groups (or tribes), which may then fight or join one another.
