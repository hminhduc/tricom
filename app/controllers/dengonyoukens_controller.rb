class DengonyoukensController < ApplicationController
  before_action :require_user!
  respond_to :html, :js

  def index
    @dengonyoukens = Dengonyouken.all
    respond_with(@dengonyoukens)
  end

  def create
    @dengonyouken = Dengonyouken.new(dengonyouken_params)
    @dengonyouken.save
    render 'share/create', locals: { obj: @dengonyouken, attr_list: Dengonyouken::SHOW_ATTRS }
  end

  def update
    @dengonyouken = Dengonyouken.find_by(id: dengonyouken_params[:id])
    @dengonyouken.update(dengonyouken_params)
    render 'share/update', locals: { obj: @dengonyouken, attr_list: Dengonyouken::SHOW_ATTRS }
  end

  def destroy
    if params[:ids]
      Dengonyouken.where(id: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @dengonyouken = Dengonyouken.find_by_id(params[:id])
      @dengonyouken.destroy if @dengonyouken
      render 'share/destroy', locals: { obj: @dengonyouken }
    end
  end

  def import
    super(Dengonyouken, dengonyoukens_path)
  end

  def export_csv
    @dengonyoukens = Dengonyouken.all
    respond_to do |format|
      format.csv { send_data @dengonyoukens.to_csv, filename: '伝言用件マスタ.csv' }
    end
  end

  private

    def dengonyouken_params
      params.require(:dengonyouken).permit(:種類名, :備考, :優先さ, :id)
    end
end
