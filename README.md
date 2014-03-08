# Space Pencil

The only feature this library currently has is an element builder with the same
DSL as SpacePen, but it returns a raw DOM element rather than a jQuery fragment.

It's exported as `$$`:

```coffee
{$$} = require 'space-pencil'

element = $$ ->
  @div class: "greeting", ->
    @h1 ->
      @text "Hello"
      @span "World"
```
