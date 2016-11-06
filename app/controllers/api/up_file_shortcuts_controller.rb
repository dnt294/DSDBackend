class Api::UpFileShortcutsController < Api::ApiController

    include ApplicationHelper

    before_action :set_up_file_shortcut, only: [:get_move, :move, :destroy]

    # GET /clone_up_file_shortcuts/1
    def clone
        @up_file_to_clone = UpFile.find(params[:up_file_id])
        @new_shortcut = UpFileShortcut.new(up_file: @up_file_to_clone,  folder: Folder.root_folder_of_user(current_user), shortcut: true)
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
        @up_file_shortcut.folder_id = params[:new_parent_id]
        if @up_file_shortcut.save
            render status: 200, json: {message: 'Di chuyển thành công!'}
        else
            render status: 401, json: {message: 'Di chuyển không thành công!'}
        end
    end

    # DELETE /up_file_shortcuts/1
    def destroy
        begin
            unless @up_file_shortcut.shortcut?
                @up_file_shortcut.up_file.destroy
            end
            @up_file_shortcut.destroy
            render status: 200, json: {message: 'Xóa shortcut thành công!'}
        rescue
            render status: 401, json: {message: 'Xóa shortcut không thành công!'}
        end

    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_up_file_shortcut
        @up_file_shortcut = UpFileShortcut.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def up_file_shortcut_params
        params.permit(:up_file_id, :folder_id)
    end

end
