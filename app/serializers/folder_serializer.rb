class FolderSerializer < ActiveModel::Serializer
    attributes :id, :name, :created_at, :updated_at, :creator_id, :ancestry, :children

    # belongs_to :creator, class_name: 'User'
    # has_one :chat_room, as: :crmable
    has_many :up_files

    def children
    	instance_options[:children]
    end

end
