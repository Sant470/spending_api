Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/signup' =>'authentication#register'
  post '/login' =>'authentication#authenticate'

  scope 'home', as: :home do
    get '/card_availability' => 'home#card_availability'
    post  '/assign_card' => 'home#assign_card'
    get '/employee/:id/transactions' => 'home#employee_transactions'
    get '/price' =>'booking#price'
  end
end
