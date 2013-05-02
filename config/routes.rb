StaticDocs::Engine.routes.draw do
  root :to => 'pages#show', :page_path => 'home'
  get '*page_path' => 'pages#show'


end
