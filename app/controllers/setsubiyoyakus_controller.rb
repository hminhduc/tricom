class SetsubiyoyakusController < ApplicationController
  before_action :require_user!
  before_action :set_setsubiyoyaku, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @hizukes = all_day_in_month_list
    @selected_date = session[:selected_date] || Date.current
    @setsubi_param = params[:head][:setsubicode] if params[:head].present?
    if @setsubi_param.present?
      @setsubiyoyakus = Setsubiyoyaku.includes(:shainmaster, :kaishamaster, :setsubi).where(設備コード: @setsubi_param)
    else
      @setsubiyoyakus = Setsubiyoyaku.includes(:shainmaster, :kaishamaster, :setsubi)
    end
    respond_with(@setsubiyoyakus)
  end

  def timeline7Day
    @selected_date = session[:selected_date] || Date.current
    @setsubi_param = params[:setsubicode] if params[:setsubicode].present?
    @setsubis = Setsubi.where('設備名 LIKE ?', "%#{@setsubi_param}%").order(:設備コード)

    if @setsubi_param.present?
      @setsubiyoyakus = Setsubiyoyaku.joins(:setsubi).where('設備マスタ.設備名 LIKE ?', "%#{@setsubi_param}%").includes(:shainmaster, :kaishamaster)
    else
      @setsubiyoyakus = Setsubiyoyaku.includes(:shainmaster, :kaishamaster, :setsubi)
    end
    @data = {
      setsubiyoyakus: build_setsubiyoyaku_json(@setsubiyoyakus),
      setsubis: build_setsubi_json(@setsubis),
      setting: { scrolltime: Setting.find_by(社員番号: session[:user]).try(:scrolltime) || '06:00' },
      holidays: JptHolidayMst.all.map { |x| x.event_date.to_s }
    }.to_json
  end

  def show
    respond_with(@setsubiyoyaku)
  end

  def new
    @kaishamasters = Kaishamaster.all
    @setsubis = Setsubi.all
    vars = request.query_parameters
    param_date = vars['start_at']
    param_setsubi = vars['setsubi_code']
    param_allday = vars['all_day']
    if param_date.nil?
      date = Date.today.to_s(:db)
    else
      date = param_date
    end

    if param_setsubi.nil?
      setsubi = Setsubi.all.first.設備コード
    else
      setsubi = param_setsubi
    end

    if param_allday == 'true'
      @setsubiyoyaku = Setsubiyoyaku.new(予約者: session[:user], 設備コード: setsubi, 開始: "#{date} 00:00", 終了: "#{date} 24:00")
    else
      @setsubiyoyaku = Setsubiyoyaku.new(予約者: session[:user], 設備コード: setsubi, 開始: "#{date} 09:00", 終了: "#{date} 18:00")
    end



    # if(!param_date.nil?)
    #   @setsubiyoyaku = Setsubiyoyaku.new(開始: '#{param_date} 09:00', 終了: '#{param_date} 18:00')
    # else
    #   @setsubiyoyaku = Setsubiyoyaku.new(開始: '#{date} 09:00', 終了: '#{date} 18:00')
    # end
    respond_with(@setsubiyoyaku)
  end

  def edit
    @kaishamasters = Kaishamaster.all
    @setsubis = Setsubi.all
  end

  def create
    @kaishamasters = Kaishamaster.all
    @setsubis = Setsubi.all
    @setsubiyoyaku = Setsubiyoyaku.new setsubiyoyaku_params
    session[:selected_date] = @setsubiyoyaku.開始 # lưu lại cái ngày vào session để sau reload chuyển đến
    if @setsubiyoyaku.save
      if params[:back] == 'timeline7Day'
        redirect_to timeline7Day_setsubiyoyakus_path
      else
        redirect_to setsubiyoyakus_url(head: { setsubicode: @setsubiyoyaku.設備コード })
      end
    else
      render :new
    end
  end

  def update
    case params[:commit]
    when (t 'helpers.submit.update')
      if @setsubiyoyaku.update_attributes(setsubiyoyaku_params)
        flash[:notice] = t 'app.flash.update_success'
        if params[:back] == 'timeline7Day'
          redirect_to timeline7Day_setsubiyoyakus_path
        else
          redirect_to setsubiyoyakus_url(head: { setsubicode: @setsubiyoyaku.設備コード })
        end
      else
        @kaishamasters = Kaishamaster.all
        @setsubis = Setsubi.all
        render :edit
        # respond_with(@setsubiyoyaku)
      end
    when (t 'helpers.submit.create_clone_other')
      create
    end
  end

  def destroy
    @setsubiyoyaku.destroy
    respond_to do |f|
      f.html { redirect_to params[:back] == 'timeline7Day' ? timeline7Day_setsubiyoyakus_path : setsubiyoyakus_path }
      f.js { render 'share/destroy', locals: { obj: @setsubiyoyaku } }
    end
  end

  def ajax
    case params[:focus_field]
    when 'setsubiyoyaku_相手先'
      kaisha_name = Kaishamaster.find_by(code: params[:kaisha_code]).try :name
      data = { kaisha_name: kaisha_name }
      respond_to do |format|
        format.json { render json: data }
      end
    when 'setsubiyoyaku_update'
      setsubiyoyaku = Setsubiyoyaku.find(params[:eventId])
      setsubiyoyaku.update(開始: params[:event_start], 終了: params[:event_end])
      data = { setsubiyoyaku: setsubiyoyaku.id }
      respond_to do |format|
        format.json { render json: data }
      end
    when 'setsubiyoyaku_削除する'
      setsubiyoyakuIds = params[:setsubiyoyakus]
      setsubiyoyakuIds.each { |setsubiyoyakuId|
        Setsubiyoyaku.find_by(id: setsubiyoyakuId).destroy
      }
      data = { destroy_success: 'success' }
      respond_to do |format|
      format.json { render json: data }
    end
    end
  end
  def import
    super(Setsubiyoyaku, setsubiyoyakus_path)
  end

  def export_csv
    @setsubiyoyakus = Setsubiyoyaku.all
    respond_to do |format|
      format.csv { send_data @setsubiyoyakus.to_csv, filename: '設備予約.csv' }
    end
  end
  private
    def set_setsubiyoyaku
      @setsubiyoyaku = Setsubiyoyaku.find(params[:id])
    end

    def setsubiyoyaku_params
      params.require(:setsubiyoyaku).permit(:設備コード, :予約者, :相手先, :開始, :終了, :用件)
    end

    def all_day_in_month_list
      d = Date.today
      (d.at_beginning_of_month.to_date..d.at_end_of_month.to_date)
    end

    def build_setsubiyoyaku_json(setsubiyoyakus)
      setsubiyoyakus.map do |setsubiyoyaku|
        {
          id: setsubiyoyaku.id,
          description: "#{ setsubiyoyaku.kaishamaster.try(:会社名) || setsubiyoyaku.相手先 }",
          title: "#{ setsubiyoyaku.用件 }\n#{ setsubiyoyaku.shainmaster.try(:氏名) } \n ",
          start: setsubiyoyaku.開始,
          end: setsubiyoyaku.終了,
          url: edit_setsubiyoyaku_path(setsubiyoyaku, back: 'timeline7Day'),
          resourceId: setsubiyoyaku.設備コード,
          shain: "#{ setsubiyoyaku.shainmaster.try(:氏名) } \n ",
          yoken: setsubiyoyaku.用件
        }
      end
    end
    def build_setsubi_json(setsubis)
      setsubis.map do |setsubi|
        {
          id: setsubi.id,
          name: setsubi.設備名,
        }
      end
    end
end
