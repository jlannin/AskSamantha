Rails.application.routes.draw do

  root 'recipes#index'

  resources :recipes

  get 'recipes/:id/delete_ingredient', to: 'recipes#del_ing', as: :del_ing
  get 'recipes/:id/add_ingredient', to: 'recipes#add_ing', as: :add_ing

end