class YuukyuuKyuukaRirekisController < ApplicationController
  before_action :set_yuukyuu_kyuuka_rireki, only: [:show, :edit, :update]
  load_and_authorize_resource except: [:export_csv, :destroy]

  def new
    @yuukyuu_kyuuka_rireki = YuukyuuKyuukaRireki.new
    respond_with(@yuukyuu_kyuuka_rireki)
  end

  def index
    session[:yuukyuu_kyuuka_rirekis_search_month] = params[:search].present? ? params[:search] : nil
    @yuukyuu_kyuuka_rirekis = YuukyuuKyuukaRireki.includes(:shainmaster)
  end

  def show
    respond_with(@yuukyuu_kyuuka_rireki)
  end

  def edit
    if session[:yuukyuu_kyuuka_rirekis_search_month] == @yuukyuu_kyuuka_rireki.年月
      ids = YuukyuuKyuukaRireki.where(年月: @yuukyuu_kyuuka_rireki.年月).order(社員番号: :asc).pluck(:id)
    else
      ids = YuukyuuKyuukaRireki.order(年月: :asc, 社員番号: :asc).pluck(:id)
    end
    @no_prev = true if @yuukyuu_kyuuka_rireki.id == ids.first
    @no_next = true if @yuukyuu_kyuuka_rireki.id == ids.last
    respond_with(@yuukyuu_kyuuka_rireki)
  end

  def create
    @yuukyuu_kyuuka_rireki = YuukyuuKyuukaRireki.new(yuukyuu_kyuuka_rireki_params)
    flash[:notice] = t 'app.flash.new_success' if @yuukyuu_kyuuka_rireki.save
    respond_with(@yuukyuu_kyuuka_rireki, location: yuukyuu_kyuuka_rirekis_url)
  end

  def update
    flash[:notice] = t 'app.flash.update_success' if @yuukyuu_kyuuka_rireki.update(yuukyuu_kyuuka_rireki_params)
    case params["commit"]
    when "←前"
      if session[:yuukyuu_kyuuka_rirekis_search_month] == @yuukyuu_kyuuka_rireki.年月
        ids = YuukyuuKyuukaRireki.where(年月: @yuukyuu_kyuuka_rireki.年月).order(社員番号: :asc).pluck(:id)
      else
        ids = YuukyuuKyuukaRireki.order(年月: :asc, 社員番号: :asc).pluck(:id)
      end
      index = ids.index(@yuukyuu_kyuuka_rireki.id)
      if index > 0
        prev_id = ids[index - 1]
        prev_object = YuukyuuKyuukaRireki.find(prev_id)
        respond_with(prev_object, location: edit_yuukyuu_kyuuka_rireki_path(prev_object))
      end
    when "次→"
      if session[:yuukyuu_kyuuka_rirekis_search_month] == @yuukyuu_kyuuka_rireki.年月
        ids = YuukyuuKyuukaRireki.where(年月: @yuukyuu_kyuuka_rireki.年月).order(社員番号: :asc).pluck(:id)
      else
        ids = YuukyuuKyuukaRireki.order(年月: :asc, 社員番号: :asc).pluck(:id)
      end
      index = ids.index(@yuukyuu_kyuuka_rireki.id)
      if index < ids.size - 1
        next_id = ids[index + 1]
        next_object = YuukyuuKyuukaRireki.find(next_id)
        respond_with(next_object, location: edit_yuukyuu_kyuuka_rireki_path(next_object))
      end
    else
      if session[:yuukyuu_kyuuka_rirekis_search_month].present?
        respond_with(@yuukyuu_kyuuka_rireki, location: yuukyuu_kyuuka_rirekis_url(search: session[:yuukyuu_kyuuka_rirekis_search_month]))
      else
        respond_with(@yuukyuu_kyuuka_rireki, location: yuukyuu_kyuuka_rirekis_url)
      end
    end
  end

  def destroy
    if params[:ids]
      begin
        params[:ids].each do |id|
          YuukyuuKyuukaRireki.find_by_id(id).try(:destroy)
        end
      rescue
      end
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    else
      @yuukyuu_kyuuka_rireki = YuukyuuKyuukaRireki.find_by_id(params[:id])
      @yuukyuu_kyuuka_rireki.destroy if @yuukyuu_kyuuka_rireki
      render 'share/destroy', locals: { obj: @yuukyuu_kyuuka_rireki }
    end
  rescue => error
    puts error
  end
  def ajax
    case params[:focus_field]
    when 'ykkkre_削除する'
      ykkkreIds = params[:ykkkres]
      ykkkreIds.each { |ykkkreId|
        YuukyuuKyuukaRireki.find(ykkkreId).destroy
      }
      data = { destroy_success: 'success' }
      respond_to do |format|
        format.json { render json: data }
      end
    when 'set_search_month'
      session[:yuukyuu_kyuuka_rirekis_search_month] = params[:yuukyuu_kyuuka_rirekis_search_month].present? ? params[:yuukyuu_kyuuka_rirekis_search_month] : nil
    end
  end
  def import
    super(YuukyuuKyuukaRireki, yuukyuu_kyuuka_rirekis_path)
  end

  def export_csv
    @yuukyuu_kyuuka_rirekis = YuukyuuKyuukaRireki.all
    respond_to do |format|
      format.csv { send_data @yuukyuu_kyuuka_rirekis.to_csv, filename: '有給休暇履歴.csv' }
    end
  end

  private
    def set_yuukyuu_kyuuka_rireki
      @yuukyuu_kyuuka_rireki = YuukyuuKyuukaRireki.find_by(id: params[:id])
    end

    def yuukyuu_kyuuka_rireki_params
      params.require(:yuukyuu_kyuuka_rireki).permit :年月, :社員番号, :月初有給残, :月末有給残
    end
end
