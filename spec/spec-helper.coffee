require 'coffee-cache'

{jsdom} = require 'jsdom'

beforeEach ->
  browser = jsdom()
  global.window = browser.parentWindow
  global.document = window.document

  @addMatchers
    toMatchMarkup: (expected) ->
      notText = if @isNot then " not" else ""

      @message = -> """
        Expected markup to#{notText} match.
        Actual: #{actualMarkup}
        Expected: #{expectedMarkup}
      """

      actual = @actual.cloneNode(true)
      actualMarkup = actual.outerHTML
      expectedMarkup = expected.replace(/\n\s*/g, '')
      actualMarkup is expectedMarkup
