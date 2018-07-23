Rails.application.routes.draw do
  require 'active_record/base'

  get 'universities/new'
  root 'static_pages#home'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  resources :article

  resources :universities do
    resources :categories
  end

end
