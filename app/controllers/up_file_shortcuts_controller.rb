class UpFileShortcutsController < ApplicationController
  before_action :set_up_file_shortcut, only: [:show, :edit, :update, :destroy]

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

  # PATCH/PUT /up_file_shortcuts/1
  def update
    if @up_file_shortcut.update(up_file_shortcut_params)
      redirect_to @up_file_shortcut, notice: 'Up file shortcut was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /up_file_shortcuts/1
  def destroy
    @up_file_shortcut.destroy
    redirect_to up_file_shortcuts_url, notice: 'Up file shortcut was successfully destroyed.'
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
