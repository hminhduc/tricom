class YakushokumastersController < ApplicationController
  before_action :require_user!
  skip_before_action :verify_authenticity_token
  respond_to :js

  def index
    @yakushokumasters = Yakushokumaster.all
  end

  def create
    @yakushokumaster = Yakushokumaster.new(yakushokumaster_params)
    flash[:notice] = t 'app.flash.new_success' if @yakushokumaster.save
    render 'share/create', locals: { obj: @yakushokumaster, attr_list: Yakushokumaster::SHOW_ATTRS }
  end

  def update
    @yakushokumaster = Yakushokumaster.find(yakushokumaster_params[:役職コード])    
    flash[:notice] = t 'app.flash.update_success' if @yakushokumaster.update(yakushokumaster_params)
    render 'share/update', locals: { obj: @yakushokumaster, attr_list: Yakushokumaster::SHOW_ATTRS }
  end

  def destroy
    if params[:ids]
      Yakushokumaster.where(id: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @yakushokumaster = Yakushokumaster.find_by_id(params[:id])
      @yakushokumaster.destroy if @yakushokumaster
      render 'share/destroy', locals: { obj: @yakushokumaster }
    end
  end

  def import
    super(Yakushokumaster, yakushokumasters_path)
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def yakushokumaster_params
    params.require(:yakushokumaster).permit(:役職コード, :役職名)
  end

end
