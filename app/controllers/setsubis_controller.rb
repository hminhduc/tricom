class SetsubisController < ApplicationController
  before_action :require_user!
  load_and_authorize_resource except: [:export_csv, :destroy, :update]
  respond_to :html, :js

  def index
    @setsubis = Setsubi.all
  end

  def create
    @setsubi = Setsubi.new(setsubi_params)
    @setsubi.save
    respond_with(@setsubi)
  end

  def update
    @setsubi = Setsubi.find_by(設備コード: setsubi_params[:設備コード])
    @setsubi.update(setsubi_params)
    respond_with(@setsubi)
  end

  def destroy
    if params[:ids]
      Setsubi.where(設備コード: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @setsubi = Setsubi.find_by(設備コード: params[:id])
      @setsubi.destroy if @setsubi
      respond_with(@setsubi)
    end
  end

  def import
    super(Setsubi, setsubis_path)
  end

  def export_csv
    @setsubis = Setsubi.all
    respond_to do |format|
      format.csv { send_data @setsubis.to_csv, filename: '設備マスタ.csv' }
    end
  end

  private

  def setsubi_params
    params.require(:setsubi).permit(:設備コード, :設備名, :備考)
  end

end
