StaticDocs.setup do
  source 'sources/root'
  source 'sources/namespace', :namespace => :namespace

  renderer :md do |body|
    "<h1>This is original markdown text</h1><pre>#{body}</pre>".html_safe
  end
end
