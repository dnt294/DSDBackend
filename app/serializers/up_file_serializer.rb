class UpFileSerializer < ActiveModel::Serializer
    
    has_one :chat_room, as: :crmable, serializer: ChatRoomSerializer    

    attributes :id, :file_name, :file_size, :file_type, :link_url, :uploader_name

    def url
        object.link.url
    end

    def uploader_name
        object.uploader.username
    end

end
