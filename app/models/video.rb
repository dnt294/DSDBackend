class Video < ApplicationRecord

    mount_uploader :link, VideoUploader

    belongs_to :folder
    belongs_to :uploader, class_name: 'User'
    has_one :chat_room, as: :crmable

    before_create :create_chat_room

    def create_chat_room
        self.build_chat_room
        true
    end
end
