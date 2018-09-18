class RorumastersController < ApplicationController
  before_action :require_user!
  load_and_authorize_resource except: [:export_csv, :destroy, :update]
  respond_to :json, :js

  def index
    @rorumasters = Rorumaster.all
  end

  def create
    @rorumaster = Rorumaster.new(rorumaster_params)
    @rorumaster.save
    render 'share/create', locals: { obj: @rorumaster, attr_list: Rorumaster::SHOW_ATTRS }
  end

  def update
    @rorumaster = Rorumaster.find_by(ロールコード: rorumaster_params[:ロールコード])
    @rorumaster.update(rorumaster_params)
    render 'share/update', locals: { obj: @rorumaster, attr_list: Rorumaster::SHOW_ATTRS }
  end

  def destroy
    if params[:ids]
      Rorumaster.where(ロールコード: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @rorumaster = Rorumaster.find_by(ロールコード: params[:id])
      @rorumaster.destroy if @rorumaster
      render 'share/destroy', locals: { obj: @rorumaster }
    end
  end

  def import
    super(Rorumaster, rorumasters_path)
  end

  def export_csv
    @rorumasters = Rorumaster.all
    respond_to do |format|
      format.csv { send_data @rorumasters.to_csv, filename: 'ロールマスタ.csv' }
    end
  end

  private

    def rorumaster_params
      params.require(:rorumaster).permit :ロールコード, :ロール名, :序列
    end
end
