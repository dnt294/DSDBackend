class FoldersController < ApplicationController

    include ApplicationHelper

    before_action :set_folder, only: [:show, :edit, :rename, :get_move, :move, :update, :destroy]
    before_action :authenticate_user!

    # GET /folders
    # GET /folders.json
    def index
        set_current_folder Folder.root_folder_of_user(current_user).id
        set_current_children
        set_new_items
        @chat_room = current_folder.chat_room
    end

    # GET /folders/1
    # GET /folders/1.json
    def show
        set_current_folder params[:id]
        set_current_children
        set_new_items
        @chat_room = current_folder.chat_room
    end

    # GET /folders/new
    def new
        @folder = Folder.new
    end

    # GET /folders/1/edit
    def edit
    end

    # POST /folders
    # POST /folders.json
    def create
        @folder = current_folder.children.create folder_params
        respond_to do |format|
            format.js {
                if @folder.save
                    set_children_folders
                    set_children_shortcuts
                else
                    @remote_error = true
                end
            }
        end

    end

    # PATCH/PUT /folders/1
    # PATCH/PUT /folders/1.json
    def update
        respond_to do |format|
            format.js {
                if @folder.update(folder_params)
                    set_children_folders
                    set_children_shortcuts
                else
                    @remote_error = true
                end
            }
        end
    end

    # DELETE /folders/1
    # DELETE /folders/1.json
    def destroy
        respond_to do |format|
            format.js {
                begin
                    # Khi xóa 1 folder:
                    # - xóa hết các file trong cây con đó (directedshare == true).
                    UpFile.joins(:up_file_shortcuts).where(up_file_shortcuts: {shortcut: false, folder_id: @folder.subtree_ids}).destroy_all
                    # - xóa hết các file shortcut tới cây con của folder (các direct shorcut tự động bị xóa khi xóa file trong câu trên)  .
                    UpFileShortcut.un_directed.where(folder_id:  @folder.subtree_ids).destroy_all
                    # - các folder của cây con tự động bị xóa -> các shortcut của folder cũng tự động bị xóa.
                    # - xóa folder
                    @folder.destroy

                    # => load lại cây thư mục
                    set_children_folders
                    set_children_shortcuts
                rescue
                    @remote_error = true
                end
            }
        end

    end

    # GET /folders/shared_with_me
    def shared_with_me
        @folders = Folder.shared_with current_user
        @up_files = UpFile.shared_with current_user
    end

    # GET /folders/1/rename
    def rename
    end

    # GET /folders/1/move
    def get_move
        @folders_tree = Folder.root_folder_of_user(current_user).subtree.arrange
    end

    def move
        @folder.parent_id = params[:new_parent_id]
        respond_to do |format|
            format.js {
                if @folder.save
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
    def set_folder
        @folder = Folder.find(params[:id])
    end

    def set_new_items
        @new_folder = Folder.new
        @new_comment = Comment.new
    end

    def set_current_children
        set_children_folders
        set_children_shortcuts
        set_children_up_file_shortcuts
    end

    def set_children_folders
        @folders = Folder.children_of current_folder
    end

    def set_children_shortcuts
        @folder_shortcuts = current_folder.shortcut_relationships.includes(:shortcut)
    end

    def set_children_up_file_shortcuts
        @up_file_shortcuts = current_folder.up_file_shortcuts.joins(:up_file).merge(UpFile.readied)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
        params.require(:folder).permit(:name, :creator_id)
    end
end
