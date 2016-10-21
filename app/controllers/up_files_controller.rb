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
        @up_file = UpFile.new up_file_params

        if @up_file.save
            respond_to do |format|
                #redirect_to current_folder
                format.html {
                    render json: [@up_file.to_jq_upload].to_json,
                    content_type: 'text/html',
                    layout: false
                }
                format.json {
                    render json: [@up_file.to_jq_upload].to_json
                }
            end
        else
            render json: [{:error => "custom_failure"}], :status => 304
            #redirect_to current_folder
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
        redirect_to current_folder, notice: 'UpFile was successfully destroyed.'
        #render :json => true

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
        params.require(:up_file).permit(:link, :file_name, :folder_id, :uploader_id)
    end
end
