class Folder < ApplicationRecord

    has_ancestry

    belongs_to :creator, class_name: 'User'
    has_one :chat_room, as: :crmable, dependent: :destroy
        
    has_many :folder_share_authorities, dependent: :destroy
    has_many :shared_users, through: :folder_share_authorities, source: :user

    ####### Quản lý các file shortcut tới thư mục ###########
    ##  1 file có nhiều đường dẫn tới các folder, tuy nhiên chỉ có 1 đường dẫn là 'direct', còn lại là 'shortcut'

    has_many :up_file_shortcuts, dependent: :destroy
    has_many :up_files, through: :up_file_shortcuts

    ####### Shortcut relation ######################

    has_many :shortcut_relationships, foreign_key: :destination_id, class_name: 'FolderShortcut', dependent: :destroy
    has_many :destination_relationships, foreign_key: :shortcut_id, class_name: 'FolderShortcut', dependent: :destroy

    has_many :shortcuts, through: :shortcut_relationships, source: :shortcut
    has_many :destinations, through: :destination_relationships, source: :destination

    accepts_nested_attributes_for :shortcut_relationships, allow_destroy: true
    accepts_nested_attributes_for :destination_relationships, allow_destroy: true

    ################################################

    scope :root_folder_of_user, ->(user) { where(creator_id: user.id, ancestry: nil).first }

    scope :children_of, ->(folder) { folder.children }

    scope :shared_with, -> (user) { user.shared_folders.merge(FolderShareAuthority.directed) }

    before_create :create_chat_room

    ###################################################

    validates :name, presence: true

    ###################################################

    def create_chat_room
        self.build_chat_room
        true
    end

    def is_directed_shared_with user
        !FolderShareAuthority.directed.where(folder_id: self.id, user_id: user.id).empty?
    end

    def is_shared_with user
        shared_users.include? user
    end


end
