class FolderSerializer < ActiveModel::Serializer
    attributes :id, :name, :ancestry, :creator_name

    def creator_name
        object.creator.username
    end    

    attributes :children

    # def shortcuts
    # 	object.shortcut_relationships
    # end
    has_many :shortcut_relationships, key: :shortcuts
    #has_many :shortcuts, through: :shortcut_relationships, source: :shortcut

    has_many :up_files
    
    has_one :chat_room
end
