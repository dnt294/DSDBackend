class UpFileShortcutsController < ApplicationController
    include ApplicationHelper
    
    before_action :set_up_file_shortcut, only: [:show, :edit, :update,  :get_move, :move, :destroy]

    # GET /up_file_shortcuts
    def index
        @up_file_shortcuts = UpFileShortcut.all
    end

    # GET /up_file_shortcuts/1
    def show
    end

    # GET /up_file_shortcuts/new
    def new
        @up_file_shortcut = UpFileShortcut.new
    end

    # GET /up_file_shortcuts/1/edit
    def edit
    end

    # POST /up_file_shortcuts
    def create
        @up_file_shortcut = UpFileShortcut.new(up_file_shortcut_params)

        if @up_file_shortcut.save
            redirect_to @up_file_shortcut, notice: 'Up file shortcut was successfully created.'
        else
            render :new
        end
    end

    # GET /clone_up_file_shortcuts/1
    def clone
        @up_file_to_clone = UpFile.find(params[:up_file_id])
        @new_shortcut = UpFileShortcut.new(up_file: @up_file_to_clone,  folder: Folder.root_folder_of_user(current_user))
        begin
            @new_shortcut.save
            redirect_to shared_with_me_folders_path
        rescue ActiveRecord::ActiveRecordError
            redirect_to shared_with_me_folders_path
        end
    end

    # PATCH/PUT /up_file_shortcuts/1
    def update
        if @up_file_shortcut.update(up_file_shortcut_params)
            redirect_to @up_file_shortcut, notice: 'Up file shortcut was successfully updated.'
        else
            render :edit
        end
    end

    def get_move
        @folders_tree = Folder.root_folder_of_user(current_user).subtree.arrange
    end

    def move        
        @up_file_shortcut.folder_id = params[:new_parent_id]
        if @up_file_shortcut.save
            redirect_to current_folder
        else
            redirect_to current_folder
        end
    end

    # DELETE /up_file_shortcuts/1
    def destroy
        if @up_file_shortcut.directed
            @up_file_shortcut.up_file.destroy
        end
        @up_file_shortcut.destroy
        redirect_to current_folder, notice: 'Đã xóa file.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_up_file_shortcut
        @up_file_shortcut = UpFileShortcut.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def up_file_shortcut_params
        params.require(:up_file_shortcut).permit(:up_file_id, :folder_id)
    end
end
