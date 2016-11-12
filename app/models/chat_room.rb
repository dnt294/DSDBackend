class ChatRoom < ApplicationRecord
    
    has_many :comments, dependent: :destroy
    has_many :users, through: :comments

    belongs_to :crmable, polymorphic: true

    def comments_with_user
        comments.includes(:user)
    end
end
