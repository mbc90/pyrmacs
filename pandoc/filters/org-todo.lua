function Str(el)
  if el.text == "TODO" then
    return pandoc.RawInline("typst", "#text(fill: rgb(\"#7FFFD4\"), weight: \"bold\")[TODO]")
  elseif el.text == "DONE" then
    return pandoc.RawInline("typst", "#text(fill: rgb(\"#DA70D6\"), weight: \"bold\")[DONE]")
  elseif el.text == "CANCELLED" then
    return pandoc.RawInline("typst", "#text(fill: rgb(\"#404040\"), weight: \"bold\")[CANCELLED]")
  elseif el.text == "IN-PROGRESS" then
    return pandoc.RawInline("typst", "#text(fill: rgb(\"#FF7F50\"), weight: \"bold\")[IN-PROGRESS]")
  elseif el.text == "WAITING" then
    return pandoc.RawInline("typst", "#text(fill: rgb(\"#5F9EA0\"), weight: \"bold\")[WAITING]")
  end
  return el
end