class UpFileShareAuthoritiesController < ApplicationController
  before_action :set_up_file_share_authority, only: [:show, :edit, :update, :destroy]

  # GET /up_file_share_authorities
  def index
    @up_file_share_authorities = UpFileShareAuthority.all
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

    if @up_file_share_authority.save
      redirect_to @up_file_share_authority, notice: 'Up file share authority was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /up_file_share_authorities/1
  def update
    if @up_file_share_authority.update(up_file_share_authority_params)
      redirect_to @up_file_share_authority, notice: 'Up file share authority was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /up_file_share_authorities/1
  def destroy
    @up_file_share_authority.destroy
    redirect_to up_file_share_authorities_url, notice: 'Up file share authority was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_up_file_share_authority
      @up_file_share_authority = UpFileShareAuthority.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def up_file_share_authority_params
      params.require(:up_file_share_authority).permit(:up_file_id, :user_id, :can_create, :can_view, :can_update, :can_destroy)
    end
end
