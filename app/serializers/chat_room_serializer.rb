class ChatRoomSerializer < ActiveModel::Serializer

    has_many :comments
    has_many :users, through: :comments
    
    attributes :id, :comments
end
