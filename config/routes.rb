Rails.application.routes.draw do
    resources :up_files
    resources :comments
    resources :folders
    root 'home#welcome'

    devise_for :users

    mount ActionCable.server => '/cable'
end
