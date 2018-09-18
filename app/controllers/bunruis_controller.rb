class BunruisController < ApplicationController
  before_action :require_user!
  respond_to :html, :js

  def index
    @bunruis = Bunrui.all
  end

  def create
    @bunrui = Bunrui.new(bunrui_params)
    flash[:notice] = t 'app.flash.new_success' if @bunrui.save
    render 'share/create', locals: { obj: @bunrui, table_id: 'bunrui_table', attr_list: Bunrui::SHOW_ATTRS }
  end

  def update
    @bunrui = Bunrui.find_by(分類コード: bunrui_params[:分類コード])
    flash[:notice] = t 'app.flash.update_success' if @bunrui.update(bunrui_params)
    render 'share/update', locals: { obj: @bunrui, table_id: 'bunrui_table', attr_list: Bunrui::SHOW_ATTRS }
  end

  def destroy
    if params[:ids]
      Bunrui.where(分類コード: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @bunrui = Bunrui.find_by(分類コード: params[:id])
      @bunrui.destroy if @bunrui
      render 'share/destroy', locals: { obj: @bunrui, table_id: 'bunrui_table' }
    end
  end

  def import
    super(Bunrui, bunruis_path)
  end

  def export_csv
    @bunruis = Bunrui.all
    respond_to do |format|
      format.csv { send_data @bunruis.to_csv, filename: '分類マスタ.csv' }
    end
  end

  private

    def bunrui_params
      params.require(:bunrui).permit(:分類コード, :分類名)
    end
end
