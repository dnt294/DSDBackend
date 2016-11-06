class Api::UpFileShareAuthoritiesController < Api::ApiController
    before_action :set_up_file_share_authority, only: [:update, :destroy]

    # GET /up_file_share_authorities
    def index
        @up_file_share_authorities = UpFileShareAuthority.of_up_file(params[:id]).includes(:user)
        render json: @up_file_share_authorities
    end

    # POST /up_file_share_authorities
    def create
        @up_file_share_authority = UpFileShareAuthority.new(up_file_share_authority_params)
        @user = User.find_by(email: params[:user_email])
        if @user.nil?
            render status: 401, json: {message: 'Không có email này!'}
        else
            @up_file_share_authority.user = @user
            begin
                @up_file_share_authority.save
                render status: 200, json: {message: "Chia sẻ với #{@user.username}"}
            rescue ActiveRecord::ActiveRecordError
                render status: 401, json: {message: "Có lỗi xảy ra ?"}
            end
        end
    end

    # PATCH/PUT /up_file_share_authorities/1
    def update

        update_rights_for_item @up_file_share_authority
        if @up_file_share_authority.save
            render status: 200, json: {message: "Sửa quyền thành công"}
        else
            render status: 401, json: {message: "Sửa quyền không thành công"}
        end
    end

    # DELETE /up_file_share_authorities/1
    def destroy

        @up_file_id = @up_file_share_authority.up_file_id
        begin
            @up_file_share_authority.destroy
            delete_all_shortcuts_for_up_file(@up_file_id, current_user)
            render status: 200, json: {message: "Xóa chia sẻ thành công"}
        rescue ActiveRecord::ActiveRecordError
            render status: 401, json: {message: "Xóa chia sẻ không thành công"}
        end

    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_up_file_share_authority
        @up_file_share_authority = UpFileShareAuthority.find(params[:id])
    end

    def delete_all_shortcuts_for_up_file(up_file_id, user)
        UpFileShortcut.where(up_file_id: up_file_id,  folder_id: user.folder_ids).delete_all
    end

    def update_rights_for_item item
        if params.has_key?(:can_view)
            item.can_view = params[:can_view]
        elsif params.has_key?(:can_rename)
            item.can_rename = params[:can_rename]
        elsif params.has_key?(:can_move)
            item.can_move = params[:can_move]
        elsif params.has_key?(:can_destroy)
            item.can_destroy = params[:can_destroy]
        end
    end

    # Only allow a trusted parameter "white list" through.
    def up_file_share_authority_params
        params.permit(:up_file_id, :user_id, :can_view, :can_rename, :can_move, :can_destroy, :direct_share)
    end
end
