class HikiaijobmastersController < ApplicationController
  before_action :require_user!
  before_action :set_jobmaster, only: [:show, :edit, :update]
  before_action :set_refer, only: [:new, :edit, :create, :update]
  load_and_authorize_resource except: [:export_csv, :destroy]
  respond_to :js

  # GET /jobmasters
  # GET /jobmasters.json
  def index
    @hikiaijobmasters = Hikiaijobmaster.all
  end

  # GET /jobmasters/1
  # GET /jobmasters/1.json
  def show
  end

  # GET /jobmasters/new
  def new
    max_job = Hikiaijobmaster.pluck(:job番号).map { |i| i.to_i }.max.to_i + 1
    # max_job = Jobmaster.maximum(:job番号) + 1
    max_job = 100001 if max_job < 100001
    @hikiaijobmaster = Hikiaijobmaster.new(job番号: max_job)
  end

  # GET /jobmasters/1/edit
  def edit
  end

  # POST /jobmasters
  # POST /jobmasters.json
  def create
    @hikiaijobmaster = Hikiaijobmaster.new(hikiaijobmaster_params)
    flash[:notice] = t 'app.flash.new_success' if @hikiaijobmaster.save
    respond_with @hikiaijobmaster, location: hikiaijobmasters_url
  end

  # PATCH/PUT /jobmasters/1
  # PATCH/PUT /jobmasters/1.json
  def update
    flash[:notice] = t 'app.flash.update_success' if @hikiaijobmaster.update(hikiaijobmaster_params)
    respond_with @hikiaijobmaster, location: hikiaijobmasters_url
  end

  # DELETE /jobmasters/1
  # DELETE /jobmasters/1.json
  def destroy
    if params[:ids]
      Hikiaijobmaster.where(id: params[:ids]).destroy_all
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @hikiaijobmaster = Hikiaijobmaster.find_by_id(params[:id])
      @hikiaijobmaster.destroy if @hikiaijobmaster
    end
  end

  def ajax
    case params[:focus_field]
    when 'hikiaijobmaster_ユーザ番号'
      kaisha_name = Kaishamaster.find(params[:kaisha_code]).try :name
      data = { kaisha_name: kaisha_name }
      respond_to do |format|
        format.json { render json: data }
      end
    when 'hikiaijobmaster_削除する'
      jobIds = params[:jobs]
      jobIds.each { |jobId|
        Hikiaijobmaster.find_by(job番号: jobId).destroy
      }
      # eki = Eki.find_by(駅コード: params[:eki_id]).destroy
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    end
  end

  def import
    super(Hikiaijobmaster, hikiaijobmasters_path)
  end

  def export_csv
    @jobs = Hikiaijobmaster.all

    respond_to do |format|
      format.html
      format.csv { send_data @jobs.to_csv, filename: 'job引合マスタ.csv' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jobmaster
      @hikiaijobmaster = Hikiaijobmaster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hikiaijobmaster_params
      params.require(:hikiaijobmaster).permit(:job番号, :job名, :開始日, :終了日, :ユーザ番号, :ユーザ名, :紹介元名, :入力社員番号, :備考)
    end

    def set_refer
      @kaishamasters = Kaishamaster.all
      @shains = Shainmaster.all
    end
end
