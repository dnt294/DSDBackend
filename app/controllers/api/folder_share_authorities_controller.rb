class Api::FolderShareAuthoritiesController < Api::ApiController

    before_action :set_folder_share_authority, only: [:show, :update, :destroy]

    def index
        @folder_share_authorities = FolderShareAuthority.of_folder(params[:id]).includes(:user)
        render json: @folder_share_authorities
    end

    def create
        @folder_share_authority = FolderShareAuthority.new(folder_share_authority_params)        
        byebug
        @user = User.find_by(email: params[:user_email])
        if @user.nil?
            render status: 401, json: {message: 'Không có email này!'}
        else
            @folder_share_authority.user = @user
            begin
                @folder_share_authority.save
                render status: 200, json: {message: "Chia sẻ với #{@user.username}"}
            rescue ActiveRecord::ActiveRecordError
                render status: 401, json: {message: "Có lỗi xảy ra ?"}
            end
        end
    end

    def update
        update_rights_for_item @folder_share_authority
        if @folder_share_authority.save
            render status: 200, json: {message: "Sửa quyền thành công"}
        else
            render status: 401, json: {message: "Sửa quyền không thành công"}
        end
    end

    def destroy
        @folder_id = @folder_share_authority.folder_id
        begin
            @folder_share_authority.destroy
            delete_all_shortcuts_for_folder(@folder_id, current_user)
            render status: 200, json: {message: "Xóa chia sẻ thành công"}
        rescue ActiveRecord::ActiveRecordError
            render status: 401, json: {message: "Xóa chia sẻ không thành công"}
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
        params.permit(:folder_id, :user_id, :can_create, :can_view, :can_rename, :can_move, :can_destroy, :direct_share)
    end
end
