class Folder < ApplicationRecord

    has_ancestry
    belongs_to :creator, class_name: 'User'

    scope :root_folder_of_user, ->(user) { where(creator_id: user.id, ancestry: nil).first }

    scope :children_of, ->(folder) { folder.children }



end
