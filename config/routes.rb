Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/registration' => 'user#registration'
  post '/login' => 'user#login'
  post '/users/username' => 'user#userprofile'

  post '/product' => 'product#allproduct'
  post '/product/search' => 'product#prodbyname'

  post '/purchase' => 'purchase#createsales'
  post '/user/username/history' => 'purchase#historysales'
end