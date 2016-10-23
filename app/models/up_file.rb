class UpFile < ApplicationRecord
    include Rails.application.routes.url_helpers

    mount_uploader :link, UpFileUploader

    belongs_to :folder
    belongs_to :uploader, class_name: 'User'
    has_one :chat_room, as: :crmable, dependent: :destroy

    before_create :create_chat_room
    #before_save :update_link_attributes

    TYPES = %W(mp4 mp3 pdf)

    def check_type type        
        
        if !self.file_type.nil?
            
            if (self.file_type.include?(type) && TYPES.include?(type))
                return true
            else
                return false
            end
        else
            return false
        end
    end

    def to_jq_upload
        {
            "name" => read_attribute(:link),
            "size" => link.size,
            "url" => link.url,
            #"thumbnail_url" => link.thumb.url,
            "delete_url" => up_file_path(self),
            "delete_type" => "DELETE"
        }
    end



    def create_chat_room
        self.build_chat_room
        true
    end

    def update_link_attributes
        if link.present? && link_changed?
            self.file_type = link.file.content_type
            self.file_size = link.file.size
            self.file_name = File.basename(link.filename,'.*').titleize
        end
    end

    def file_type_s
        TYPES.each do |type|
            byebug
            if self.file_type.includes?(type)
                byebug
                return type
            end            
        end
    end

end
