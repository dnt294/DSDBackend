class FolderShortcutSerializer < ActiveModel::Serializer

    attributes :id, :shortcut_id, :shortcut_name, :shortcut_created_at, :shortcut_updated_at, :shortcut_creator_id

    def shortcut_id
    	object.shortcut.id
    end
    def shortcut_name
    	object.shortcut.name
    end
    def shortcut_created_at
    	object.shortcut.created_at
    end
    def shortcut_updated_at
    	object.shortcut.updated_at
    end
    def shortcut_creator_id
    	object.shortcut.creator_id
    end


    #belongs_to :shortcut, class_name: 'Folder'

end
