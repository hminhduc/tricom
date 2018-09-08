class BunruisController < ApplicationController
  before_action :require_user!
  respond_to :html, :js

  def index
    @bunruis = Bunrui.all
  end

  def create
    @bunrui = Bunrui.new(bunrui_params)
    flash[:notice] = t 'app.flash.new_success' if @bunrui.save
    render 'share/create', locals: { obj: @bunrui, table_id: 'bunrui_table', attr_list: %w(分類コード 分類名) }
  end

  def update
    @bunrui = Bunrui.find_by(分類コード: bunrui_params[:分類コード])
    flash[:notice] = t 'app.flash.update_success' if @bunrui.update(bunrui_params)
    render 'share/update', locals: { obj: @bunrui, table_id: 'bunrui_table', attr_list: %w(分類コード 分類名) }
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
    if params[:file].nil?
      flash[:alert] = t 'app.flash.file.nil'
      redirect_to bunruis_path
    elsif File.extname(params[:file].original_filename) != '.csv'
      flash[:danger] = t 'app.flash.file_format_invalid'
      redirect_to bunruis_path
    else
      if notice = import_from_csv(Bunrui, params[:file])
        flash[:danger] = notice
        redirect_to bunruis_path
      else
        notice = t 'app.flash.import_csv'
        redirect_to :back, notice: notice
      end
      end
    end
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
