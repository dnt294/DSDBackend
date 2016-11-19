class FolderShareAuthoritiesController < ApplicationController
    before_action :set_folder_share_authority, only: [:show, :edit]

    # GET /folder_share_authorities
    def index
        respond_to do |format|
            format.js {                
                @folder_share_authorities = FolderShareAuthority.of_folder(params[:id]).includes(:user)
                @folder_id = params[:id]
            }
        end
    end

    # GET /folder_share_authorities/1
    def show
    end

    # GET /folder_share_authorities/new
    def new
        @folder_share_authority = FolderShareAuthority.new
    end

    # GET /folder_share_authorities/1/edit
    def edit
    end

    # POST /folder_share_authorities
    def create
        @folder_share_authority = FolderShareAuthority.new(folder_share_authority_params)
        @user = User.find_by(email: params[:user_email])
         @folder = Folder.find(params[:folder_share_authority][:folder_id])
        if @user.nil?
            @remote_error = {error: 'Khong tim thay email nay.'}
        elsif @user == @folder.creator
	    @remote_error = { error: 'User nay chinh la nguoi tao folder nay.' }
        else
            @folder_share_authority.user = @user
            begin
                @folder_share_authority.save
            rescue ActiveRecord::ActiveRecordError
	    @remote_error = { error: 'Da chia se voi nguoi nay roi.' }
            end
        end

        respond_to do |format|
                format.js {
                    @folder_share_authorities = FolderShareAuthority.of_folder(@folder_share_authority.folder_id).includes(:user)
                }                
            end
    end

    # PATCH/PUT /folder_share_authorities/1
    def update
        begin
            @folder_share_authority = FolderShareAuthority.find(params[:id])
        rescue ActiveRecord::ActiveRecordError
        end
        update_rights_for_item @folder_share_authority
        if @folder_share_authority.save
            respond_to do |format|
                format.js {
                    @folder_share_authorities = FolderShareAuthority.of_folder(@folder_share_authority.folder_id).includes(:user)
                }
                format.html {
                    redirect_to @folder_share_authority, notice: 'Folder share authority was successfully updated.'
                }
            end
        else
            respond_to do |format|
                format.js {
                    @folder_share_authorities = FolderShareAuthority.of_folder(@folder_share_authority.folder_id).includes(:user)
                }
                format.html {
                    render :edit
                }
            end
        end
    end

    # DELETE /folder_share_authorities/1
    def destroy
	begin
            @folder_share_authority = FolderShareAuthority.find(params[:id])
        rescue ActiveRecord::ActiveRecordError
        end
        # khi xóa chia sẻ -> xóa luôn cả các shortcut của chia sẻ đó.
        @folder_id = @folder_share_authority.folder_id
        begin
            @folder_share_authority.destroy
            delete_all_shortcuts_for_folder(@folder_id, current_user)
            respond_to do |format|
                format.js {
                    @folder_share_authorities = FolderShareAuthority.of_folder(@folder_id).includes(:user)
                }
                format.html {
                    redirect_to folder_share_authorities_url, notice: 'Folder share authority was successfully destroyed.'
                }
            end
        rescue ActiveRecord::ActiveRecordError
            respond_to do |format|
                format.js {
                    @folder_share_authorities = FolderShareAuthority.of_folder(@folder_id).includes(:user)
                }
                format.html {
                    redirect_to folder_share_authorities_url, notice: 'Folder share authority was successfully destroyed.'
                }
            end
        end

    end

    # Khi 1 người tự xóa chia sẻ đó trong "share with me" page.
    def self_destroy
        @folder_id = params[:folder_id]
        @folder_share_authority = FolderShareAuthority.find_by(folder_id: @folder_id, user: current_user)
        begin
            @folder_share_authority.destroy
            delete_all_shortcuts_for_folder(@folder_id, current_user)
            redirect_to shared_with_me_folders_path
        rescue ActiveRecord::ActiveRecordError
            redirect_to shared_with_me_folders_path
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder_share_authority
        @folder_share_authority = FolderShareAuthority.find(params[:id])
    end

    def delete_all_shortcuts_for_folder(folder_id, user)
        FolderShortcut.where(shortcut_id: folder_id, destination_id: user.folder_ids).delete_all
    end

    def update_rights_for_item item
        if params.has_key?(:can_create)
            item.can_create = params[:can_create]
        elsif params.has_key?(:can_view)
            item.can_view = params[:can_view]
        elsif params.has_key?(:can_rename)
            item.can_rename = params[:can_rename]
        elsif params.has_key?(:can_move)
            item.can_move = params[:can_move]
        elsif params.has_key?(:can_destroy)
            item.can_destroy = params[:can_destroy]
        end
    end

    def share_all_desendants folder, input_user
        un_shared_folder_yet = folder.descendants.where.not(id: input_user.shared_folder_ids)

        un_shared_file_yet =  un_shared_folder_yet.map {
            |f| f.up_files.where.not(uploader_id: input_user.id)
        }
        self_un_shared_file_yet = folder.up_files.where.not(uploader_id: input_user.id)
        un_shared_folder_yet.each do |new_folder|
            FolderShareAuthority.create(folder: new_folder, user: input_user)
        end
        un_shared_file_yet.each do |new_file|
            UpFileShareAuthority.where(up_file: new_file.first, user: input_user).first_or_create
        end
        self_un_shared_file_yet.each do |new_file|
            UpFileShareAuthority.where(up_file: new_file, user: input_user).first_or_create
        end
    end

    # Only allow a trusted parameter "white list" through.
    def folder_share_authority_params
        params.require(:folder_share_authority).permit(:folder_id, :user_id, :user_email, :can_create, :can_view, :can_rename, :can_move, :can_destroy, :direct_share)
    end
end
