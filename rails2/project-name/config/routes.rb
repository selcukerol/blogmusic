Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/'=>'home#index'
  get '/page2' => 'home#page2'
  get '/page3' => 'home#page3'
end

