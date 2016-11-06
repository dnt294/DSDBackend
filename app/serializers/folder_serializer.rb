class FolderSerializer < ActiveModel::Serializer
    attributes :id, :name, :created_at, :updated_at, :ancestry, :children, :chat_room, :up_files, :creator_name

    def creator_name
        object.creator.username
    end

    has_one :chat_room, as: :crmable, serializer: ChatRoomSerializer   
    
    has_many :up_files, through: :up_file_shortcuts

    has_many :shortcuts, through: :shortcut_relationships, source: :shortcut
    
end
