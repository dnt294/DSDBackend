Rails.application.routes.draw do

    root 'home#welcome'

    resources :up_file_share_authorities
    resources :folder_share_authorities

    delete 'self_destroy_folder_authority', to: 'folder_share_authorities#self_destroy', as: :self_destroy_folder_authority
    delete 'self_destroy_up_file_authority', to: 'up_file_share_authorities#self_destroy', as: :self_destroy_up_file_authority

    resources :up_file_shortcuts do
        collection do
            get :clone
        end
        member do
            get 'get_move'
            post 'move'
        end
    end

    resources :up_files do
        member do
            get 'rename'
        end
    end

    resources :folder_shortcuts, only: [:destroy] do
        collection do
            get :clone
        end
        member do
            get 'get_move'
            post 'move'
        end
    end


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

    resources :comments

    devise_for :users

    ################################ Api ##################################

    namespace :api do
        resources :tokens, only: [:create, :destroy]

        resources :up_file_share_authorities, only: [:index, :create, :update, :destroy]
        resources :folder_share_authorities, only: [:index, :create, :update, :destroy]

        resources :up_file_shortcuts, only: [:destroy] do
            collection do
                get :clone
            end
            member do
                get 'get_move'
                post 'move'
            end
        end

        resources :up_files, only: [:show, :update, :destroy]

        resources :folder_shortcuts, only: [:destroy] do
            collection do
                get :clone
            end
            member do
                get 'get_move'
                post 'move'
            end
        end

        resources :folders, only: [:index, :show, :create, :update, :destroy] do
            collection do
                get 'shared_with_me'
            end
            member do
                get 'get_move'
                post 'move'
            end
        end

        resources :comments, only: [:create]

    end

    ################################ Cable ##################################

    mount ActionCable.server => '/cable'
end
