class Api::FoldersController < Api::ApiController

    include ApplicationHelper

    before_action :set_folder, only: [:show, :move, :update, :destroy]

    def index
        @folder = Folder.root_folder_of_user(current_user)#.children.arrange_serializable
        render json: @folder
    end

    def show
        render json: @folder
    end

    def create
        @folder = Folder.new(folder_params)
        @folder.creator = current_user
        if @folder.save
            render status: 200, json: {message: 'Tạo folder thành công!', folder: @folder}
        else
            render status: 401, json: {message: 'Tạo folder không thành công!'}
        end
    end

    def update

        if @folder.update(folder_params)
            render status: 200, json: {message: 'Sửa folder thành công!', folder: @folder}
        else
            render status: 401, json: {message: 'Sửa folder không thành công!'}
        end
    end

    def destroy
        begin
            # Khi xóa 1 folder:
            # - xóa hết các file trong cây con đó (directedshare == true).
            UpFile.joins(:up_file_shortcuts).where(up_file_shortcuts: {shortcut: false, folder_id: @folder.subtree_ids}).destroy_all
            # - xóa hết các file shortcut tới cây con của folder (các direct shorcut tự động bị xóa khi xóa file trong câu trên)  .
            UpFileShortcut.un_directed.where(folder_id:  @folder.subtree_ids).destroy_all
            # - các folder của cây con tự động bị xóa -> các shortcut của folder cũng tự động bị xóa.

            # - xóa folder
            @folder.destroy
            render status: 200, json: {message: 'Xóa folder thành công!'}
        rescue
            render status: 401, json: {message: 'Xóa folder không thành công!'}
        end

    end

    def get_move
        @folders_tree = Folder.root_folder_of_user(current_user).subtree.arrange_serializable
        render json: @folders_tree
    end

    def move
        @folder.parent_id = params[:new_parent_id]
        if @folder.save
            render status: 200, json: {message: 'Move folder thành công!'}
        else
            render status: 401, json: {message: 'Move folder không thành công!'}
        end
    end

    private

    def set_folder
        begin
            @folder = Folder.find(params[:id])
        rescue
            render status: 401, json: {message: 'Không có folder này!'}
        end
    end

    def folder_params
        params.permit(:name, :creator_id, :parent_id)
    end
end
