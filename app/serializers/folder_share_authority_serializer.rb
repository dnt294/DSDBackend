class FolderShareAuthoritySerializer < ActiveModel::Serializer

    has_one :folder
    has_one :user
    
    attributes :id, :can_create, :can_view, :can_update, :can_destroy

end
