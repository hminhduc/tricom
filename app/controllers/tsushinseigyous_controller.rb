class TsushinseigyousController < ApplicationController
  before_action :require_user!
  respond_to :html, :js

  def index
    @tsushinseigyous = Tsushinseigyou.all
    respond_with(@tsushinseigyous)
  end

  def create
    @tsushinseigyou = Tsushinseigyou.new(tsushinseigyou_params)
    @tsushinseigyou.save
    render 'share/create', locals: { obj: @tsushinseigyou, attr_list: Tsushinseigyou::SHOW_ATTRS }
  end

  def update
    @tsushinseigyou = Tsushinseigyou.find_by(社員番号: tsushinseigyou_params[:社員番号])
    @tsushinseigyou.update(tsushinseigyou_params)
    render 'share/update', locals: { obj: @tsushinseigyou, attr_list: Tsushinseigyou::SHOW_ATTRS }
  end

  def destroy
    if params[:ids]
      Tsushinseigyou.where(id: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @tsushinseigyou = Tsushinseigyou.find_by_id(params[:id])
      @tsushinseigyou.destroy if @tsushinseigyou
      render 'share/destroy', locals: { obj: @tsushinseigyou }
    end
  end

  def import
    super(Tsushinseigyou, tsushinseigyous_path)
  end

  def export_csv
    @tsushinseigyous = Tsushinseigyou.all
    respond_to do |format|
      format.csv { send_data @tsushinseigyous.to_csv, filename: '通信制御マスタ.csv' }
    end
  end

  private

    def tsushinseigyou_params
      params.require(:tsushinseigyou).permit(:社員番号, :メール, :送信許可区分, :id)
    end
end
