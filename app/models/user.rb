class User < ApplicationRecord

    ######################   Devise ######################################
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:username]

    def self.find_for_database_authentication(warden_conditions)
        conditions = warden_conditions.dup
        if username = conditions.delete(:username)
            where(conditions.to_h).where(["lower(username) = :value", { :value => username.downcase }]).first
        elsif conditions.has_key?(:username)
            where(conditions.to_h).first
        end
    end

    ########################################################################

    has_many :folders, foreign_key: 'creator_id', class_name: 'Folder'

    has_many :comments
    has_many :chat_rooms, through: :comments

end
