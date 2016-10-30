class FolderShareAuthority < ApplicationRecord
    belongs_to :folder
    belongs_to :user

    scope :of_folder, -> (id) { where(folder_id: id) }

    scope :directed, -> { where(direct_share: true ) }
    scope :un_directed, -> { where(direct_share: false ) }

    validates :direct_share, :folder_id, :user_id, presence: true, allow_blank: true

end
