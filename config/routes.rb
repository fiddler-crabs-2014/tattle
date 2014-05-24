Rails.application.routes.draw do
  root to: 'main#index'
  match '/search', to: 'main#search', via: 'get'
end
