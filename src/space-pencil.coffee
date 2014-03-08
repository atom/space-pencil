Builder = require '../src/builder'
builder = new Builder

exports.$$ = (fn) -> builder.buildElement(fn)
