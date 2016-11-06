class Api::UpFilesController < Api::ApiController

    include ApplicationHelper

    before_action :set_up_file, only: [:show, :update, :destroy]

    # GET /up_files/1
    def show
        render json: @up_file
    end

    # PATCH/PUT /up_files/1
    def update
        if @up_file.update(up_file_params)
            render status: 200, json: {message: 'Sửa tên thành công!', up_file: @up_file}
        else
            render status: 401, json: {message: 'Sửa tên không thành công!'}
        end
    end

    # DELETE /up_files/1
    def destroy
        begin
            @up_file.destroy
            render status: 200, json: {message: 'Xóa File thành công!'}
        rescue
            render status: 401, json: {message: 'Xóa File không thành công!'}
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_up_file
        @up_file = UpFile.find(params[:id])
    end

    def save_direct_shortcut_for_file up_file, folder_id
        shortcut = UpFileShortcut.new(up_file: up_file, folder_id: folder_id)
        shortcut.save
    end

    # Only allow a trusted parameter "white list" through.
    def up_file_params
        params.permit(:link, :file_name, :uploader_id, :temp_up_id, up_file_shortcuts_params: [:up_file_id, :folder_id])
    end

end
