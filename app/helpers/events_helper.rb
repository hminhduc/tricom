module EventsHelper
  def get_koutei_name(koutei_code, user_id)
    shozoku_code = User.find(user_id).shainmaster.try :所属コード
    Kouteimaster.find_by(所属コード: shozoku_code, 工程コード: koutei_code).try :工程名
  end

  def set_fkey(event, event_params)
    event.joutaimaster = Joutaimaster.find_by 状態コード: event_params[:状態コード]
    event.bashomaster = Bashomaster.find_by 場所コード: event_params[:場所コード]
    event.kouteimaster = Kouteimaster.find_by 所属コード: event_params[:所属コード], 工程コード: event_params[:工程コード]
    # event.shozai = Shozai.find_by 所在コード: event_params[:所在コード]
    event.jobmaster = Jobmaster.find_by job番号: event_params[:JOB]
  end

  def check_user_status
    Shainmaster.all.each do |shain|
      if shain.events.where('Date(開始) = ?', Date.current).count == 0
        event_start_datetime = Date.current.to_s + ' 09:00'
        event_end_datetime = Date.current.to_s + ' 18:00'
        event = Event.new(社員番号: shain.社員番号, 状態コード: '0', 開始: event_start_datetime, 終了: event_end_datetime)
        event.joutaimaster = Joutaimaster.find_by(状態コード: '0')
        event.shainmaster = shain
        event.save
      end
    end
  end

  def kitaku
    # shain = User.find(session[:user]).shainmaster
    shain = Shainmaster.find session[:selected_shain]

    # event_search = shain.events.where("Date(終了) = ?",Date.today.to_s(:db))
    # .events.where("Date(終了) = ?", Time.now)

    end_time = Date.today.to_s(:db) << ' 18:00'
    event = Event.create(shain_no: shain.shain_no, start_time: Time.now, end_time: end_time, joutai_code: '99')
    event.shainmaster = shain
    event.joutaimaster = Joutaimaster.find_by(code: '99')
    event.save
  end

  def caculate_koushuu(time_start, time_end)
    results = time_calculate(time_start, time_end)
    (results[:real_hours] + results[:fustu_zangyo] + results[:shinya_zangyou]) / 30 * 0.5
  end
  # Tao ra mot mang chua cac thoi diem (tinh theo phut) nam trong danh sach cac events:
  def create_event_times(begin_of_day, events)
    time_array, no_zangyou_time_array = [], [] # no_zangyou_time_array la mang cac thoi diem khong tinh zangyou
    events.each do |event|
      event_start_time = ((event.開始.to_time - begin_of_day) / 60).to_i
      event_end_time = ((event.終了.to_time - begin_of_day) / 60).to_i
      time_array |= (event_start_time...event_end_time).to_a
      no_zangyou_time_array |= (event_start_time...event_end_time).to_a if event.joutaimaster.try(:残業計算外区分) == '1'
    end
    [time_array, no_zangyou_time_array]
  rescue
    nil
  end

  def kyuukei_time_calculate(start_t, end_t, event_times = nil) # start va end tinh theo don vi phut
    hiru_kyukei = yoru_kyukei = shinya_kyukei = souchou_kyukei = real_hours = 0
    time_array, no_zangyou_time_array = event_times
    (start_t...end_t).each do |t|
      next if time_array && !time_array.include?(t)
      case (t / 60) % 24 # tinh xem thoi diem t ung voi may gio trong ngay.
      when 12 then hiru_kyukei += 1 # tuong duong 12:00->13:00
      when 18
        real_hours += 1
        yoru_kyukei += 0
      when 23
        real_hours += 1
        shinya_kyukei += 0
      when 4, 5, 6
        real_hours += 1
        souchou_kyukei += 0
      else real_hours += 1
      end
    end
    {
      hiru_kyukei: hiru_kyukei,
      yoru_kyukei: yoru_kyukei,
      shinya_kyukei: shinya_kyukei,
      souchou_kyukei: souchou_kyukei,
      real_hours: real_hours
    }
  end

  def zangyou_time_calculate(start_t, end_t, event_times = nil)
    fustu_zangyo = shinya_zangyou = 0
    time_array, no_zangyou_time_array = event_times # no_zangyou_time_array la mang cac thoi diem khong tinh zangyou
    (start_t...end_t).each do |t|
      next if time_array && !time_array.include?(t)
      case (t / 60) % 24 # tinh xem thoi diem t ung voi may gio trong ngay.
      when 16, 17, 19, 20, 21, 22 then fustu_zangyo += 1 unless no_zangyou_time_array.try(:include?, t)
      when 0, 1, 2, 3 then shinya_zangyou += 1 unless no_zangyou_time_array.try(:include?, t)
      end
    end
    {
      fustu_zangyo: fustu_zangyo,
      shinya_zangyou: shinya_zangyou
    }
  end

  def chikoku_soutai_time_calculate(kinmu_start, start_time, end_time, kinmu_end)
    chikoku = start_time - kinmu_start
    chikoku = 0 if chikoku < 0
    soutai = kinmu_end - end_time
    soutai = 0 if soutai < 0
    {
      chikoku: 0,#chikoku,
      soutai: 0#soutai
    }
  end

  def time_calculate(start_time, end_time, kinmu_type = nil, events = nil)
    # quy doi start_time, end_time ra phut:
    begin_of_day = start_time.to_time.beginning_of_day
    start_time = ((start_time.to_time - begin_of_day) / 60).to_i
    end_time = ((end_time.to_time - begin_of_day) / 60).to_i

    # tao danh sach cac thoi diem thuoc events:
    event_times = create_event_times(begin_of_day, events)

    # quy doi thoi gian chuan cua kinmu_type ra phut
    if kinmu_type.present?
      kinmu_start = (Kintai::KINMU_TYPE[kinmu_type][:s] * 60).to_i
      kinmu_end = (Kintai::KINMU_TYPE[kinmu_type][:e] * 60).to_i
    else
      kinmu_start, kinmu_end = 0, 1439 # 00:00->23:59
    end

    if Kintai::KINMU_TYPE.keys.include? kinmu_type
      if start_time <= kinmu_start
        if kinmu_start < end_time # se bat dau dem tu kinmu_start
          results = kyuukei_time_calculate(kinmu_start, end_time, event_times)
          if end_time < kinmu_end # dem den end_time
            # start_time <= kinmu_start < end_time < kinmu_end
            results.merge!(fustu_zangyo: 0, shinya_zangyou: 0)
            results.merge!(chikoku_soutai_time_calculate(kinmu_start, start_time, end_time, kinmu_end))
          else # if end_time >= kinmu_end
            # start_time <= kinmu_start < kinmu_end <= end_time
            results.merge!(zangyou_time_calculate(kinmu_end, end_time, event_times))
            results.merge!(chikoku: 0, soutai: 0)
          end
        else  # if kinmu_start >= end_time then nothing to do
          return {}
        end
      else # if start_time > kinmu_start thi chikoku > 0
        if start_time < kinmu_end # thi tinh tu start_time den thoi diem nho nhat trong [kinmu_end, end_time]
          results = kyuukei_time_calculate(start_time, [kinmu_end, end_time].min, event_times)
          results.merge!(fustu_zangyo: 0, shinya_zangyou: 0)
          results.merge!(chikoku_soutai_time_calculate(kinmu_start, start_time, end_time, kinmu_end))
        else # if start_time >= kinmu_end then nothing to do
          return {}
        end
      end
    else # Kintai::KINMU_TYPE.keys not include kinmu_type
      results = kyuukei_time_calculate(start_time, end_time, event_times)
      results.merge!(zangyou_time_calculate(start_time, end_time, event_times))
      results.merge!(chikoku: 0, soutai: 0)
    end # case kinmu_type
    results[:real_hours] -= results[:fustu_zangyo] + results[:shinya_zangyou]
    results
  end
end
