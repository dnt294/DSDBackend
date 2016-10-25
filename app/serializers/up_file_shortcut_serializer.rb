class UpFileShortcutSerializer < ActiveModel::Serializer
  attributes :id
  has_one :up_file
  has_one :folder
end
