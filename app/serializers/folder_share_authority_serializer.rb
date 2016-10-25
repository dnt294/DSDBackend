class FolderShareAuthoritySerializer < ActiveModel::Serializer
  attributes :id, :can_create, :can_view, :can_update, :can_destroy
  has_one :folder
  has_one :user
end
