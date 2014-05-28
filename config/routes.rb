Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root to: 'main#index'
  match '/search', to: 'main#search', via: 'get'
  match '/children', to: 'main#children', via: 'get'
end
