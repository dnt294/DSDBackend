class UpFileShareAuthoritiesController < ApplicationController
    before_action :set_up_file_share_authority, only: [:show, :edit]

    # GET /up_file_share_authorities
    def index
        respond_to do |format|
            format.js {                
                @up_file_share_authorities = UpFileShareAuthority.of_up_file(params[:id]).includes(:user)
                @up_file_id = params[:id]
            }
        end
    end

    # GET /up_file_share_authorities/1
    def show
    end

    # GET /up_file_share_authorities/new
    def new
        @up_file_share_authority = UpFileShareAuthority.new
    end

    # GET /up_file_share_authorities/1/edit
    def edit
    end

    # POST /up_file_share_authorities
    def create
        @up_file_share_authority = UpFileShareAuthority.new(up_file_share_authority_params)
         @up_file = UpFile.find(params[:up_file_share_authority][:up_file_id])
        @user = User.find_by(email: params[:user_email])
        if @user.nil?
            @remote_error = {error: 'Khong tim thay email nay.'}
        elsif @user == @up_file.uploader
	    @remote_error = { error: 'User nay chinh la nguoi tao file nay.' }
        else
            @up_file_share_authority.user = @user
            begin
                @up_file_share_authority.save
            rescue ActiveRecord::ActiveRecordError
	    @remote_error = { error: 'Da chia se voi nguoi nay roi.' }
            end            
        end       

       respond_to do |format|
                format.js {
                    @up_file_share_authorities = UpFileShareAuthority.of_up_file(@up_file_share_authority.up_file_id).includes(:user)
                }                
            end
    end

    # PATCH/PUT /up_file_share_authorities/1
    def update
        begin
            @up_file_share_authority = UpFileShareAuthority.find(params[:id])
        rescue ActiveRecord::ActiveRecordError
        end

        update_rights_for_item @up_file_share_authority
        if @up_file_share_authority.save
            respond_to do |format|
                format.js {
                    @up_file_share_authorities = UpFileShareAuthority.of_up_file(@up_file_share_authority.up_file_id).includes(:user)
                }
                format.html {
                    redirect_to @up_file_share_authority, notice: 'File share authority was successfully updated.'
                }
            end
        else
            respond_to do |format|
                format.js {
                    @up_file_share_authorities = UpFileShareAuthority.of_up_file(@up_file_share_authority.up_file_id).includes(:user)
                }
                format.html {
                    render :edit
                }
            end
        end
    end

    # DELETE /up_file_share_authorities/1
    def destroy
        begin
            @up_file_share_authority = UpFileShareAuthority.find(params[:id])
        rescue ActiveRecord::ActiveRecordError
        end

        @up_file_id = @up_file_share_authority.up_file_id
        begin
            @up_file_share_authority.destroy
            delete_all_shortcuts_for_up_file(@up_file_id, current_user)
            respond_to do |format|
                format.js {
                    @up_file_share_authorities = UpFileShareAuthority.of_up_file(@up_file_id).includes(:user)
                }
                format.html {
                    redirect_to up_file_share_authorities_url, notice: 'File share authority was successfully destroyed.'
                }
            end
        rescue ActiveRecord::ActiveRecordError
            respond_to do |format|
                format.js {
                    @up_file_share_authorities = UpFileShareAuthority.of_up_file(@up_file_id).includes(:user)
                }
                format.html {
                    redirect_to up_file_share_authorities_url, notice: 'File share authority was successfully destroyed.'
                }
            end
        end

    end

    # Khi 1 người tự xóa chia sẻ đó trong "share with me" page.
    def self_destroy
        # tìm file muốn dừng chia sẻ
        @up_file_id = params[:up_file_id]
        @up_file_share_authority = UpFileShareAuthority.find_by(up_file_id: @up_file_id, user: current_user)
        # xóa hết các shortcut tới folder này.
        begin
            @up_file_share_authority.destroy
            delete_all_shortcuts_for_up_file(@up_file_id, current_user)
            redirect_to shared_with_me_folders_path
        rescue ActiveRecord::ActiveRecordError
            redirect_to shared_with_me_folders_path
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
        params.require(:up_file_share_authority).permit(:up_file_id, :user_id, :can_view, :can_rename, :can_move, :can_destroy, :direct_share)
    end
end
