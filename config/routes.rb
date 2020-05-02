Rails.application.routes.draw do
  # resources :widgets
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # namespace defaults: { format: 'json' } do
  namespace :boggle, defaults: {format: :json} do
    get 'getMatrix', to: 'boggle#getMatrix'
    post 'saveWord', to: 'boggle#saveWord'
    post 'getScore', to: 'boggle#getScore'
    resources :boggle
  end
  root 'boggle/boggle#index'

  get "*path" => redirect("/")
end
