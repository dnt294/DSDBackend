Rails.application.routes.draw do
	
  resources :up_file_share_authorities
  resources :folder_share_authorities
  resources :up_file_shortcuts
	resources :up_files

    resources :comments
    resources :folders
    root 'home#welcome'

    devise_for :users

    namespace :api do
    	resources :tokens, only: [:create, :destroy]
        resources :folders, only: [:index, :show, :create, :update, :destroy]
    end

    mount ActionCable.server => '/cable'
end
