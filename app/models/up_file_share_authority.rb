class UpFileShareAuthority < ApplicationRecord
  belongs_to :up_file
  belongs_to :user
end
