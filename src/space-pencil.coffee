Builder = require './builder'
builder = new Builder

exports.$$ = (fn) -> builder.buildElement(fn)
