class UpFilesController < ApplicationController
    include ApplicationHelper

    before_action :set_up_file, only: [:show, :edit, :update, :destroy]
    before_action :set_new_items, only: [:show]

    # GET /up_files
    def index
        @up_files = UpFile.all
    end

    # GET /up_files/1
    def show
        @chat_room = @up_file.chat_room
    end

    # GET /up_files/new
    def new
        @up_file = UpFile.new
    end

    # GET /up_files/1/edit
    def edit
    end

    # POST /up_files
    def create
        @up_file = UpFile.create up_file_params
        if @up_file.save
            redirect_to current_folder
        else
            redirect_to current_folder
        end
    end

    # PATCH/PUT /up_files/1
    def update
        if @up_file.update(up_file_params)
            redirect_to @up_file, notice: 'UpFile was successfully updated.'
        else
            render :edit
        end
    end

    # DELETE /up_files/1
    def destroy
        @up_file.destroy
        redirect_to up_files_url, notice: 'UpFile was successfully destroyed.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_up_file
        @up_file = UpFile.find(params[:id])
    end

    def set_new_items
        @new_comment = Comment.new
    end

    # Only allow a trusted parameter "white list" through.
    def up_file_params
        params.require(:up_file).permit(:link, :name, :folder_id, :uploader_id, :link_cache)
    end
end
