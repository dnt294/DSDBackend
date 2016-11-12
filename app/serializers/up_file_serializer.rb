class UpFileSerializer < ActiveModel::Serializer

    attributes :id, :file_name, :file_size, :file_type, :link_url, :uploader_name

    has_one :chat_room

    def url
        object.link.url
    end

    def uploader_name
        object.uploader.username
    end

end
