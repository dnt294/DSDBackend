class FolderShareAuthority < ApplicationRecord
    belongs_to :folder
    belongs_to :user

    scope :of_folder, -> (id) { where(folder_id: id) }
end
