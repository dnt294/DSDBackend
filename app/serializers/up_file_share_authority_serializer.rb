class UpFileShareAuthoritySerializer < ActiveModel::Serializer
  attributes :id, :can_create, :can_view, :can_update, :can_destroy
  has_one :up_file
  has_one :user
end
