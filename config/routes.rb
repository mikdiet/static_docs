StaticDocs::Engine.routes.draw do
  root :to => 'pages#show'
  get '*page_path' => 'pages#show', :as => :page

end
