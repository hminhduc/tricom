class DengonkaitousController < ApplicationController
  before_action :require_user!
  respond_to :html, :js

  def index
    @dengonkaitous = Dengonkaitou.all
    respond_with(@dengonkaitous)
  end

  def create
    @dengonkaitou = Dengonkaitou.new(dengonkaitou_params)
    @dengonkaitou.save
    render 'share/create', locals: { obj: @dengonkaitou, table_id: 'dengonkaitoumaster', attr_list: %w(id 種類名 備考) }
  end

  def update
    @dengonkaitou = Dengonkaitou.find_by(id: dengonkaitou_params[:id])
    @dengonkaitou.update(dengonkaitou_params)
    render 'share/update', locals: { obj: @dengonkaitou, table_id: 'dengonkaitoumaster', attr_list: %w(id 種類名 備考) }
  end

  def destroy
    if params[:ids]
      Dengonkaitou.where(id: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @dengonkaitou = Dengonkaitou.find_by_id(params[:id])
      @dengonkaitou.destroy if @dengonkaitou
      render 'share/destroy', locals: { obj: @dengonkaitou, table_id: 'dengonkaitoumaster' }
    end
  end

  def import
    super(Dengonkaitou, dengonkaitous_path)
  end

  def export_csv
    @dengonkaitous = Dengonkaitou.all
    respond_to do |format|
      format.csv { send_data @dengonkaitous.to_csv, filename: '伝言回答マスタ.csv' }
    end
  end

  private

  def dengonkaitou_params
    params.require(:dengonkaitou).permit(:種類名, :備考, :id)
  end

end
