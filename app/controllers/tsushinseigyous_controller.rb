class TsushinseigyousController < ApplicationController
  before_action :require_user!
  before_action :set_tsushinseigyou, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @tsushinseigyous = Tsushinseigyou.all
    respond_with(@tsushinseigyous)
  end

  def show
    respond_with(@tsushinseigyou)
  end

  def new
    @tsushinseigyou = Tsushinseigyou.new
  end

  def edit
  end

  def create
    @tsushinseigyou = Tsushinseigyou.new(tsushinseigyou_params)
    @tsushinseigyou.save
    respond_with(@tsushinseigyou, location: tsushinseigyous_url)
  end

  def update
    @tsushinseigyou.update(tsushinseigyou_params)
    respond_with(@tsushinseigyou, location: tsushinseigyous_url)
  end

  def destroy
    @tsushinseigyou.destroy
    respond_with(@tsushinseigyou)
  end

  def import
    if params[:file].nil?
      flash[:alert] = t 'app.flash.file_nil'
      redirect_to tsushinseigyous_path
    elsif File.extname(params[:file].original_filename) != '.csv'
      flash[:danger] = t 'app.flash.file_format_invalid'
      redirect_to tsushinseigyous_path
    else
      begin
        Tsushinseigyou.transaction do
          Tsushinseigyou.delete_all
          Tsushinseigyou.reset_pk_sequence
          Tsushinseigyou.import(params[:file])
          notice = t 'app.flash.import_csv'
          redirect_to :back, notice: notice
        end
      rescue => err
        flash[:danger] = err.to_s
        redirect_to tsushinseigyous_path
      end
    end
  end

  def export_csv
    @tsushinseigyous = Tsushinseigyou.all

    respond_to do |format|
      format.html
      format.csv { send_data @tsushinseigyous.to_csv, filename: '通信制御マスタ.csv' }
    end
  end

  def ajax
    case params[:focus_field]
      when 'tsushinseigyou_削除する'
        tsushinseigyouIds = params[:tsushinseigyous]
        tsushinseigyouIds.each{ |tsushinseigyouId|
          Tsushinseigyou.find_by(id: tsushinseigyouId).destroy
        }
        data = {destroy_success: 'success'}
        respond_to do |format|
        format.json { render json: data}
      end
    end
  end

   def create_tsushinseigyou
    @tsushinseigyou = Tsushinseigyou.new(tsushinseigyou_params)
    respond_to do |format|
      if  @tsushinseigyou.save
        format.js { render 'create_tsushinseigyou'}
      else
        format.js { render json: @tsushinseigyou.errors, status: :unprocessable_entity}
      end
    end
    end

  def update_tsushinseigyou
    @tsushinseigyou = Tsushinseigyou.find_by(社員番号: tsushinseigyou_params[:社員番号])
    # @eki.update(eki_params)
    # redirect_to ekis_path
    respond_to do |format|
      if  @tsushinseigyou.update(tsushinseigyou_params)
        format.js { render 'update_tsushinseigyou'}
      else
        format.js { render json: @tsushinseigyou.errors, status: :unprocessable_entity}
      end
    end
  end
  
  private
    def set_tsushinseigyou
      @tsushinseigyou = Tsushinseigyou.find(params[:id])
    end

    def tsushinseigyou_params
      params.require(:tsushinseigyou).permit(:社員番号, :メール, :送信許可区分, :id)
    end

end
