class Api::FolderShortcutsController < Api::ApiController

    include ApplicationHelper

    before_action :set_folder_shortcut, only: [:get_move, :move, :destroy]

    # GET api/clone_folder_shortcuts/1
    def clone
        @folder_to_clone = Folder.find(params[:folder_id])
        @new_shortcut = FolderShortcut.new(shortcut: @folder_to_clone, destination: Folder.root_folder_of_user(current_user))
        begin
            @new_shortcut.save
            render status: 200, json: {message: 'Tạo shortcut thành công!'}
        rescue ActiveRecord::ActiveRecordError
            render status: 401, json: {message: 'Tạo shortcut không thành công!'}
        end
    end

    def get_move
        @folders_tree = Folder.root_folder_of_user(current_user).subtree.arrange_serializable
        render json: @folders_tree
    end

    def move
        @folder_shortcut.destination_id = params[:new_parent_id]
        if @folder_shortcut.save
            render status: 200, json: {message: 'Di chuyển thành công!'}
        else
            render status: 401, json: {message: 'Di chuyển không thành công!'}
        end
    end

    # DELETE /folder_shortcuts/1
    def destroy
        if @folder_shortcut.destroy
            render status: 200, json: {message: 'Xóa shortcut thành công!'}
        else
            render status: 401, json: {message: 'Xóa shortcut không thành công!'}
        end
    end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder_shortcut
        @folder_shortcut = FolderShortcut.find(params[:id])
    end
end
