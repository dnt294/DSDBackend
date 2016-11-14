module FoldersHelper

    def set_current_children
        set_children_folders
        set_children_shortcuts
        set_children_up_file_shortcuts
    end

    def set_children_folders
        @folders = Folder.children_of current_folder
    end

    def set_children_shortcuts
        @folder_shortcuts = current_folder.shortcut_relationships.includes(:shortcut)
    end

    def set_children_up_file_shortcuts
        @up_file_shortcuts = current_folder.up_file_shortcuts.joins(:up_file).merge(UpFile.readied)
    end

end
