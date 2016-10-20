class UpFile < ApplicationRecord

    mount_uploader :link, UpFileUploader

    belongs_to :folder
    belongs_to :uploader, class_name: 'User'
    has_one :chat_room, as: :crmable

    before_create :create_chat_room
    before_save :update_link_attributes

    def file_type
        return 'mp4' if self.content_type.contain('mp4')
        return 'mp3' if self.content_type.contain('mp3')
        return 'pdf' if self.content_type.contain('pdf')
        return nil
    end

    TYPES = %W(mp4 mp3 pdf)

    def check_type type
        if !self.content_type.nil?
            if (self.content_type.include?(type) && TYPES.include?(type))
                return true
            else
                return false
            end
        else
            return false
        end
    end

    def create_chat_room
        self.build_chat_room
        true
    end

    def update_link_attributes
        if link.present? && link_changed?
            self.content_type = link.file.content_type
            self.file_size = link.file.size
        end
    end

end
