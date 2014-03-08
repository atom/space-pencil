TagNames = """
  a abbr address area article aside audio b base bdi bdo big blockquote body br
  button canvas caption cite code col colgroup data datalist dd del details dfn
  div dl dt em embed fieldset figcaption figure footer form h1 h2 h3 h4 h5 h6
  head header hr html i iframe img input ins kbd keygen label legend li link main
  map mark menu menuitem meta meter nav noscript object ol optgroup option output
  p param pre progress q rp rt ruby s samp script section select small source
  span strong style sub summary sup table tbody td textarea tfoot th thead time
  title tr track u ul var video wbr circle g line path polyline rect svg text
""".split(/\s+/)

SelfClosingTags = {}
"area base br col command embed hr img input keygen link meta param source
track wbr".split(/\s+/).forEach (tag) -> SelfClosingTags[tag] = true

module.exports =
class Builder
  for tagName in TagNames
    do (tagName) => @::[tagName] = (args...) -> @tag(tagName, args...)

  buildElement: (fn) ->
    wrapper = document.createElement('div')
    wrapper.innerHTML = @buildHtml(fn)
    wrapper.firstChild

  buildHtml: (fn) ->
    @document = []
    fn.call(this)
    @document.join('')

  tag: (name, args...) ->
    for arg in args
      switch typeof arg
        when 'function' then content = arg
        when 'string', 'number' then text = arg.toString()
        when 'object' then attributes = arg

    @openTag(name, attributes)

    if SelfClosingTags.hasOwnProperty(name)
      if text? or content?
        throw new Error("Self-closing tag #{name} cannot have text or content")
    else
      content.call(this) if content?
      @text(text) if text?
      @closeTag(name)

  openTag: (name, attributes) ->
    attributePairs =
      for attributeName, value of attributes
        "#{attributeName}=\"#{value}\""

    attributesText =
      if attributePairs.length
        " " + attributePairs.join(" ")
      else
        ""

    @document.push("<#{name}#{attributesText}>")

  closeTag: (name) ->
    @document.push("</#{name}>")

  text: (text) ->
    escapedText = text
      .replace(/&/g, '&amp;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
    @document.push(escapedText)

  raw: (text) ->
    @document.push(text)
