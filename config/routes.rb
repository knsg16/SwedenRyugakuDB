Rails.application.routes.draw do
  require 'active_record/base'

  get 'universities/new'
  root 'static_pages#home'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  resources :article do
    member do
      get 'delete'
    end
  end
  
  resources :blog, only: [:index, :new, :create]


  resources :universities do
    resources :categories
  end

end
