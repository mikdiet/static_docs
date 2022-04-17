module ApplicationHelper
  def markdown(text)
    "<h1>This is original markdown text</h1><pre>#{text}</pre>".html_safe
  end
end
