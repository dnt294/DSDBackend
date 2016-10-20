class ChatRoom < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :users, through: :comments

    def comments_with_user
        comments.includes(:user)
    end
end
