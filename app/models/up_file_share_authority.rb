class UpFileShareAuthority < ApplicationRecord
    belongs_to :up_file
    belongs_to :user

    scope :of_up_file, -> (id) { where(up_file_id: id) }

    scope :directed, -> { where(direct_share: true ) }
    scope :un_directed, -> { where(direct_share: false ) }

    validates :direct_share, :up_file_id, :user_id, presence: true, allow_blank: true

    
end
