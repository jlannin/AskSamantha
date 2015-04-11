Rails.application.routes.draw do

  devise_for :users, controllers:
    { omniauth_callbacks: "omniauth_callbacks" }
    root 'recipes#index'

  resources :recipes do 
    resources :reviews, :only => [:create, :new]
  end

  get 'recipes/:id/delete_ingredient', to: 'recipes#del_ing', as: :del_ing
  get 'recipes/:id/add_ingredient', to: 'recipes#add_ing', as: :add_ing

end
