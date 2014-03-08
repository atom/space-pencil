Builder = require '../src/builder'

describe "Builder", ->
  it "builds an DOM elements based on the given function", ->
    builder = new Builder
    element = builder.buildElement ->
      @div class: "greeting", ->
        @h1 ->
          @text "Hello"
          @span "World"

    expect(element).toMatchMarkup """
      <div class="greeting">
        <h1>Hello<span>World</span></h1>
      </div>
    """
