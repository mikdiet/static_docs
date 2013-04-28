Rails.application.routes.draw do

  mount StaticDocs::Engine => "/static_docs"
end
