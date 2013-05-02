StaticDocs::Engine.routes.draw do
  root :to => 'pages#index'
  get '*page_path' => 'pages#show'


end
