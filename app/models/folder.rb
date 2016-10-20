class Folder < ApplicationRecord

    has_ancestry
    belongs_to :creator, class_name: 'User'
    has_one :chat_room, as: :crmable
    has_many :videos
    scope :root_folder_of_user, ->(user) { where(creator_id: user.id, ancestry: nil).first }

    scope :children_of, ->(folder) { folder.children }

    before_create :create_chat_room

    def create_chat_room
        self.build_chat_room
        true
    end

end
