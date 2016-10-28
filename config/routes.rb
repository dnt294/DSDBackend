Rails.application.routes.draw do

    root 'home#welcome'

    resources :up_file_share_authorities
    resources :folder_share_authorities
    resources :up_file_shortcuts
    resources :up_files do
        member do
            get 'rename'
            get 'get_move'
            post 'move'
        end
    end

    resources :comments
    
    resources :folders do
        collection do
            get 'shared_with_me'
        end
        member do
            get 'rename'
            get 'get_move'
            post 'move'
        end
    end
    

    devise_for :users

    namespace :api do
        resources :tokens, only: [:create, :destroy]
        resources :folders, only: [:index, :show, :create, :update, :destroy]
    end

    mount ActionCable.server => '/cable'
end
