class SagyoukubunsController < ApplicationController
  before_action :require_user!
  respond_to :json, :js

  def index
    @sagyoukubuns = Sagyoukubun.all
    respond_with(@sagyoukubuns)
  end

  def create
    @sagyoukubun = Sagyoukubun.new(sagyoukubun_params)
    flash[:notice] = t 'app.flash.new_success' if @sagyoukubun.save
    respond_with(@sagyoukubun)
  end

  def update
    @sagyoukubun = Sagyoukubun.find_by(作業区分: sagyoukubun_params[:作業区分])
    flash[:notice] = t 'app.flash.update_success' if @sagyoukubun.update(sagyoukubun_params)
    respond_with(@sagyoukubun)
  end

  def destroy
    if params[:ids]
      Sagyoukubun.where(id: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @sagyoukubun = Sagyoukubun.find_by_id(params[:id])
      @sagyoukubun.destroy if @sagyoukubun
      respond_with(@sagyoukubun)
    end
  end

  private

  def sagyoukubun_params
    params.require(:sagyoukubun).permit(:作業区分, :作業区分名称)
  end

end
