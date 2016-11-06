class ChatRoomSerializer < ActiveModel::Serializer

    has_many :comments, serializer: CommentSerializer
    
    attributes :comments
end
