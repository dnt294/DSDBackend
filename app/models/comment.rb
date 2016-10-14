class Comment < ApplicationRecord

    #belongs_to :commentable, polymorphic: true, optional: true
    belongs_to :chat_room
    belongs_to :user
end
