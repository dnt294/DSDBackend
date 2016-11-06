class UpFileShortcutSerializer < ActiveModel::Serializer

    has_one :up_file
    has_one :folder

    attributes :id
end
