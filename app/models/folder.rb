class Folder < ApplicationRecord

    has_ancestry
    belongs_to :creator, class_name: 'User'

    scope :root_folder?, -> { where(ancestry: nil) }
    scope :root_of_user, ->(user) { where(creator_id: user.id).root_folder? }


end
