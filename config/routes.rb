Rails.application.routes.draw do
  get 'universities/new'
  root 'static_pages#home'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  resources :universities do
    resources :categories
  end

end
