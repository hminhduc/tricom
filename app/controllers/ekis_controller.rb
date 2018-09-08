class EkisController < ApplicationController
  before_action :require_user!
  load_and_authorize_resource except: [:export_csv, :destroy, :update]
  respond_to :json, :js

  def index
    @ekis = Eki.all
    respond_with(@ekis)
  end

  def create
    @eki = Eki.new(eki_params)
    flash[:notice] = t 'app.flash.new_success' if @eki.save
    respond_with(@eki)
  end

  def update
    @eki = Eki.find_by(駅コード: eki_params[:駅コード])
    flash[:notice] = t 'app.flash.update_success' if @eki.update(eki_params)
    respond_with(@eki)
  end

  def destroy
    if params[:ids]
      Eki.where(id: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @eki = Eki.find_by_id(params[:id])
      @eki.destroy if @eki
      respond_with(@eki)
    end
  end

  def import
    super(Eki, ekis_path)
  end

  def export_csv
    @ekis = Eki.all
    respond_to do |format|
      format.csv { send_data @ekis.to_csv, filename: '駅マスタ.csv' }
    end
  end

  private

  def eki_params
    params.require(:eki).permit(:駅コード, :駅名, :駅名カナ)
  end

end
