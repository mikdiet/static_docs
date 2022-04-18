Rails.application.routes.draw do
  mount StaticDocs::Engine => "/"
end
