class FolderSerializer < ActiveModel::Serializer
    attributes :id, :name, :created_at, :updated_at, :creator_id, :ancestry, :children, :chat_room, :up_files
    
    has_one :chat_room, as: :crmable
    has_many :up_files

    has_many :folder_share_authorities
    has_many :shared_users, through: :folder_share_authorities, source: :user

    has_many :up_file_shortcuts
    has_many :up_files, through: :up_file_shortcuts

    has_many :shortcut_relationships, foreign_key: :destination_id, class_name: 'FolderShortcut'
    has_many :destination_relationships, foreign_key: :shortcut_id, class_name: 'FolderShortcut'

    has_many :shortcuts, through: :shortcut_relationships, source: :shortcut
    has_many :destinations, through: :destination_relationships, source: :destination

    
end
