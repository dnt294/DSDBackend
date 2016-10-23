class UpFileSerializer < ActiveModel::Serializer
    attributes :id, :file_name, :file_size, :file_type, :link_url
        
    def url
    	object.link.url
    end
end
