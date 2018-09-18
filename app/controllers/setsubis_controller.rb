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
    render 'share/create', locals: { obj: @setsubi, attr_list: Setsubi::SHOW_ATTRS }
  end

  def update
    @setsubi = Setsubi.find_by(設備コード: setsubi_params[:設備コード])
    @setsubi.update(setsubi_params)
    render 'share/update', locals: { obj: @setsubi, attr_list: Setsubi::SHOW_ATTRS }
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
      render 'share/destroy', locals: { obj: @setsubi }
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
