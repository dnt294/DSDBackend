class CommentSerializer < ActiveModel::Serializer

    belongs_to :chat_room
    belongs_to :user

    attributes :id
    
end
