class JobuchiwakesController < ApplicationController
  before_action :require_user!
  respond_to :json, :js

  def index
    @jobuchiwakes = Jobuchiwake.all.decorate
    respond_with(@jobuchiwakes)
  end

  def create
    @jobuchiwake = Jobuchiwake.new(jobuchiwake_params).decorate
    flash[:notice] = t 'app.flash.new_success' if @jobuchiwake.save
    respond_with(@jobuchiwake.decorate)
  end

  def update
    @jobuchiwake = Jobuchiwake.find_by(ジョブ内訳番号: jobuchiwake_params[:ジョブ内訳番号]).decorate
    flash[:notice] = t 'app.flash.update_success' if @jobuchiwake.update(jobuchiwake_params)
    respond_with(@jobuchiwake)
  end

  def destroy
    if params[:ids]
      Jobuchiwake.where(id: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @jobuchiwake = Jobuchiwake.find_by_id(params[:id])
      @jobuchiwake.destroy if @jobuchiwake
      respond_with(@jobuchiwake)
    end
  end

  private

  def jobuchiwake_params
    params.require(:jobuchiwake).permit(:ジョブ番号, :ジョブ内訳番号, :受付日時, :件名, :受付種別)
  end

end
