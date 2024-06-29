function Div(div)
  -- Process custom callouts
  if div.classes:includes("my-callout") then
    local title = div.attributes["title"] or nil

    -- Use the first element of the div as the title if it's a header and no title attribute is provided
    if not title and div.content[1] ~= nil and div.content[1].t == "Header" then
      title = pandoc.utils.stringify(div.content[1])
      div.content:remove(1)
    end

    -- Generate LaTeX tcolorbox environment for PDF
    if quarto.doc.is_format("pdf") then
      local content = pandoc.write(pandoc.Pandoc(div.content), "latex")
      if title then
        return pandoc.RawBlock("latex", "\\begin{tcolorbox}[myquote, title={" .. title .. "}]\n" .. content .. "\n\\end{tcolorbox}")
      else
        return pandoc.RawBlock("latex", "\\begin{tcolorbox}[myquote]\n" .. content .. "\n\\end{tcolorbox}")
      end
    else
      -- For other formats (HTML), use the Quarto callout
      if title then
        return quarto.Callout({
          type = "definition",
          content = { pandoc.Div(div) },
          title = title,
          collapse = false
        })
      else
        return quarto.Callout({
          type = "definition",
          content = { pandoc.Div(div) },
          collapse = false
        })
      end
    end
  end
end