class RorumenbasController < ApplicationController
  before_action :set_rorumenba, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource except: :export_csv

  def new
    @shains = Shainmaster.all
  	@rorumenba = Rorumenba.new
    respond_with(@rorumenba)
  end

  def index
    @shains = Shainmaster.all
  	@rorumenbas = Rorumenba.includes(:shainmaster, :rorumaster)
  end

  def show
    @shains = Shainmaster.all
    respond_with(@rorumenba)
  end

  def edit
    @shainna = Shainmaster.find_by(社員番号: @rorumenba.社員番号).氏名
    respond_with(@rorumenba)
  end

  def create
    arrShain = params[:shain].split(',')
    arrShain.each do |shainNo|
      @rorumenba = Rorumenba.find_by({社員番号: shainNo, ロールコード: rorumenba_params[:ロールコード]})
      next if !@rorumenba.nil?
      @shainna = Shainmaster.find_by(社員番号: shainNo)
      @rorumenba = Rorumenba.new(rorumenba_params.merge({社員番号: shainNo,氏名:  @shainna.氏名}))
      @rorumenba.save
    end
    respond_with(@rorumenba, location: rorumenbas_url)
  end

  def update
    flash[:notice] = t 'app.flash.update_success' if @rorumenba.update(rorumenba_params)
    respond_with(@rorumenba, location: rorumenbas_url)
  end

  def destroy
    @shains = Shainmaster.all
    @rorumenba.destroy if @rorumenba
    render 'share/destroy', locals: { obj: @rorumenba, obj_id: @rorumenba.id.try(:join, '-') }
  end

  def import
    super(Rorumenba, rorumenbas_path)
  end

  def export_csv
    @rorumenbas = Rorumenba.all
    respond_to do |format|
       format.csv { send_data @rorumenbas.to_csv, filename: 'ロールメンバ.csv' }
    end
  end

  private
    def set_rorumenba
      @rorumenba = Rorumenba.find(params[:id])
    end

    def rorumenba_params
      params.require(:rorumenba).permit :ロールコード, :社員番号, :氏名, :ロール内序列
    end
end
