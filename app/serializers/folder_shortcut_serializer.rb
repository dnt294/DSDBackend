class FolderShortcutSerializer < ActiveModel::Serializer

    attributes :id

    belongs_to :shortcut, class_name: 'Folder'    

end
