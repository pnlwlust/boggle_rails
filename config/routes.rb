Rails.application.routes.draw do
  # resources :widgets
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # namespace defaults: { format: 'json' } do
    namespace :boggle, defaults: {format: :json} do
    get 'getMatrix', to: 'getMatrix'
    post 'saveWord', to: 'saveWord'
    post 'getScore', to: 'getScore'
  end
  # resources :boggle
  # root 'boggle#index'
  root 'boggle#index'

    get "*path" => redirect("/")
end
