class ChatRoomSerializer < ActiveModel::Serializer
    
    attribute :id

    has_many :comments

end
