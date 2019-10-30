Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  default_url_options :host => "example.com"
  
  resources :users, only: %i[create] do
    get :activate, action: :activate, on: :member
  end

end
