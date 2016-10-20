class VideosController < ApplicationController
    include ApplicationHelper

    before_action :set_video, only: [:show, :edit, :update, :destroy]
    before_action :set_new_items, only: [:show]

    # GET /videos
    def index
        @videos = Video.all
    end

    # GET /videos/1
    def show
        @chat_room = @video.chat_room
    end

    # GET /videos/new
    def new
        @video = Video.new
    end

    # GET /videos/1/edit
    def edit
    end

    # POST /videos
    def create
        @video = Video.create video_params
        respond_to do |format|
            if @video.save
                format.js {
                    @new_video = Video.new
                    @videos = current_folder.videos
                }
            else
                format.html {
                    render :new
                }
                format.js {

                }
            end
        end
    end

    # PATCH/PUT /videos/1
    def update
        if @video.update(video_params)
            redirect_to @video, notice: 'Video was successfully updated.'
        else
            render :edit
        end
    end

    # DELETE /videos/1
    def destroy
        @video.destroy
        redirect_to videos_url, notice: 'Video was successfully destroyed.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
        @video = Video.find(params[:id])
    end

    def set_new_items
        @new_comment = Comment.new
    end

    # Only allow a trusted parameter "white list" through.
    def video_params
        params.require(:video).permit(:link, :name, :folder_id, :uploader_id, :link_cache)
    end
end
