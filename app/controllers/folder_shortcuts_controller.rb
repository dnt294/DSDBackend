class FolderShortcutsController < ApplicationController

    include ApplicationHelper
    include FoldersHelper

    before_action :set_folder_shortcut, only: [:get_move, :move, :destroy]

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

    def get_move
        @folders_tree = Folder.root_folder_of_user(current_user).subtree.arrange
    end

    def move
        @folder_shortcut.destination_id = params[:new_parent_id]
        if @folder_shortcut.save
            redirect_to current_folder
        else
            redirect_to current_folder
        end
    end

    # DELETE /folder_shortcuts/1
    def destroy
        respond_to do |format|
            format.js {
                if @folder_shortcut.destroy
                    set_children_folders
                    set_children_shortcuts
                else
                    @remote_error = true
                end
            }
        end

    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder_shortcut
        @folder_shortcut = FolderShortcut.find(params[:id])
    end

end
