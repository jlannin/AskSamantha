Rails.application.routes.draw do

  get 'sessions/new'

  devise_for :users, controllers:
    { omniauth_callbacks: "omniauth_callbacks" }
  root 'recipes#home'

  resources :recipes do 
    resources :reviews, :only => [:create, :new]
  end
  get 'home/', to: 'recipes#home', as: :home
  get 'fridge/', to: 'users#show_fridge', as: :show_fridge
  get 'fridge/edit', to: 'users#edit_fridge', as: :edit_fridge

  get 'recipes/cookable', to: 'recipes#can_cook', as: :can_cook
	put 'recipes/:id/cook', to: 'recipes#cook_recipe', as: :cook_recipe

  put 'fridge/update', to: 'users#update', as: :update_fridge
  get 'fridge/delete_grocery', to: 'users#del_groc', as: :del_groc

  get 'recipes/:id/delete_ingredient', to: 'recipes#del_ing', as: :del_ing
  get 'recipes/:id/add_ingredient', to: 'recipes#add_ing', as: :add_ing

end
