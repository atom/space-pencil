##### Atom and all repositories under Atom will be archived on December 15, 2022. Learn more in our [official announcement](https://github.blog/2022-06-08-sunsetting-atom/)
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
