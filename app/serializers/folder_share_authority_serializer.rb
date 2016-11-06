class FolderShareAuthoritySerializer < ActiveModel::Serializer

    attributes :id, :can_create, :can_view, :can_update, :can_destroy, :user_name, :user_email

    def user_name
    	object.user.username
    end

    def user_email
    	object.user.email
    end

end
