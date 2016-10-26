class UpFileShareAuthoritiesController < ApplicationController
    before_action :set_up_file_share_authority, only: [:show, :edit, :update, :destroy]

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
        @user = User.find_by(email: params[:user_email])
        @up_file_share_authority.user = @user

        if @up_file_share_authority.save
            respond_to do |format|
                format.js {
                    @up_file_share_authorities = UpFileShareAuthority.of_up_file(@up_file_share_authority.up_file_id).includes(:user)
                }
                format.html {
                    redirect_to @up_file_share_authority, notice: 'Up file share authority was successfully created.'
                }
            end

        else
            respond_to do |format|
                format.js {
                    @up_file_share_authorities = UpFileShareAuthority.of_up_file(@up_file_share_authority.up_file_id).includes(:user)
                }
                format.html {
                    render :new
                }
            end

        end
    end

    # PATCH/PUT /up_file_share_authorities/1
    def update

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

        @up_file_id = @up_file_share_authority.up_file_id
        @up_file_share_authority.destroy
        respond_to do |format|
            format.js {
                @up_file_share_authorities = UpFileShareAuthority.of_up_file(@up_file_id).includes(:user)
            }
            format.html {
                redirect_to up_file_share_authorities_url, notice: 'File share authority was successfully destroyed.'
            }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_up_file_share_authority
        @up_file_share_authority = UpFileShareAuthority.find(params[:id])
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
