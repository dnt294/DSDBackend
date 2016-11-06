class UpFileShareAuthoritySerializer < ActiveModel::Serializer

    has_one :up_file
    has_one :user

    attributes :id, :can_create, :can_view, :can_update, :can_destroy
end
