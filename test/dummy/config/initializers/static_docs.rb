StaticDocs.setup do
  source 'sources/root'
  source 'sources/namespace', :namespace => :namespace

  renderer :md do |body|
    markdown(body)
  end

  renderer :txt do |body, page|
    page.meta[:test] = 'test'
    page.meta[:test] * 3
  end
end
