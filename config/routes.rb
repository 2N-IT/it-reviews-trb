Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  default_url_options :host => "example.com"

  get 'users/:activation_token/activate', to: 'users#activate', as: 'activate_user'
  resources :users, only: %i[create new show]
end
