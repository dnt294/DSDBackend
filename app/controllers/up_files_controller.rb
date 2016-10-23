class UpFilesController < ApplicationController
    include ApplicationHelper

    before_action :set_up_file, only: [:show, :continue_upload, :edit, :update, :destroy]
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

        # File tạm được upload lên
        @temp_upfile = UpFile.new up_file_params

        content_range = request.headers['CONTENT-RANGE']

        if content_range.nil? #file nhỏ hơn 5MB, lưu ko ko phải tính :D
            @temp_upfile.save
            return
        end

        content_length = request.headers['CONTENT-LENGTH'].to_i

        begin_of_chunk = content_range[/\ (.*?)-/,1].to_i
        # "bytes 100-999999/1973660678" will return '100'

        if (begin_of_chunk == 0)
            
            @temp_upfile.save
        else
            @up_file = UpFile.find_by(temp_up_id: @temp_upfile.temp_up_id)            
            @up_file.file_size += content_length
            
            File.open(@up_file.link.path, "ab") do |f|                
                f.write(up_file_params[:link].read)
            end
            
            @up_file.save
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
        params.require(:up_file).permit(:link, :file_name, :folder_id, :uploader_id, :temp_up_id)
    end
end
