class FolderShortcut < ApplicationRecord

	belongs_to :shortcut, class_name: 'Folder'
	belongs_to :destination, class_name: 'Folder'

	validates :shortcut_id, presence: true
	validates :destination_id, presence: true
	
end