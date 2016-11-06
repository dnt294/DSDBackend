class UpFileShortcutSerializer < ActiveModel::Serializer

    has_one :up_file    

    attributes :id
    
end
