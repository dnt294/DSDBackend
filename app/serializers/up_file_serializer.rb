class UpFileSerializer < ActiveModel::Serializer

    belongs_to :uploader, class_name: 'User'
    has_one :chat_room, as: :crmable

    has_many :up_file_share_authorities
    has_many :shared_users, through: :up_file_share_authorities, source: :user

    has_many :up_file_shortcuts
    has_many :folders, through: :up_file_shortcuts

    attributes :id, :file_name, :file_size, :file_type, :link_url

    def url
        object.link.url
    end
end
