class FolderShortcutsController < ApplicationController

    include ApplicationHelper

    # GET /clone_folder_shortcuts/1
    def clone
        @folder_to_clone = Folder.find(params[:folder_id])
        @new_shortcut = FolderShortcut.new(shortcut: @folder_to_clone, destination: Folder.root_folder_of_user(current_user))
        begin
            @new_shortcut.save
            redirect_to shared_with_me_folders_path
        rescue ActiveRecord::ActiveRecordError
            redirect_to shared_with_me_folders_path
        end
    end



end
