class BashomastersController < ApplicationController
  before_action :require_user!
  skip_before_action :verify_authenticity_token
  before_action :set_kaishamst, only: [:new, :create, :show, :edit, :update]
  before_action :set_bashomaster, only: [:show, :edit, :update]
  load_and_authorize_resource except: [:export_csv, :destroy]
  respond_to :js, :html

  def index
    @bashomasters = Bashomaster.includes(:bashokubunmst, :kaishamaster).order(:場所コード)
  end

  def show
  end

  def new
    @bashomaster = Bashomaster.new
  end

  def edit
  end

  def create
    @bashomaster = Bashomaster.new(bashomaster_params)
    if @bashomaster.save
      flash[:notice] = t 'app.flash.new_success'
      redirect_to bashomasters_path
    else
      render 'new'
    end
  end

  def update
    if @bashomaster.update bashomaster_params
      flash[:notice] = t 'app.flash.update_success'
      redirect_to bashomasters_path
    else
      render 'edit'
    end
  end

  def destroy
    if params[:ids]
      Bashomaster.where(id: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @bashomaster = Bashomaster.find_by_id(params[:id])
      @bashomaster.destroy if @bashomaster
      render 'share/destroy', locals: { obj: @bashomaster }
    end
  end

  def ajax
    case params[:focus_field]
    when 'bashomaster_会社コード'
      kaisha_name = Kaishamaster.find_by(code: params[:kaisha_code]).try :name
      data = { kaisha_name: kaisha_name }
      respond_to do |format|
        format.json { render json: data }
      end
    when 'basho_削除する'
      params[:bashos].each { |basho_code|
        basho = Bashomaster.find(basho_code)
        basho.destroy if basho
      }
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
    end
  end

  def import
    super(Bashomaster, bashomasters_path)
  end

  def export_csv
    @bashomasters = Bashomaster.all
    respond_to do |format|
      format.csv { send_data @bashomasters.to_csv, filename: '場所マスタ.csv' }
    end
  end

  private

    def bashomaster_params
      params.require(:bashomaster).permit(:場所コード, :場所名, :場所名カナ, :SUB, :場所区分, :会社コード)
    end

    def set_bashomaster
      @bashomaster = Bashomaster.find_by(id: params[:id])
    end

    def set_kaishamst
      @kaishamasters = Kaishamaster.all
    end
end
