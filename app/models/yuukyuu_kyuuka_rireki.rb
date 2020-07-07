class YuukyuuKyuukaRireki < ApplicationRecord
  self.table_name = :有給休暇履歴
  CSV_HEADERS = %w{社員番号 氏名 年月 月初有給残 月末有給残}
  SHOW_ATTRS = %w(id 社員番号 氏名 年月 月初有給残 月末有給残)
  include PgSearch
  multisearchable against: %w{社員番号 年月 }
  validates :年月, :社員番号, presence: true
  validates :年月, uniqueness: { scope: :社員番号 }
  belongs_to :shainmaster, foreign_key: :社員番号
  after_save :update_getshozan_of_next_month
  delegate :氏名, to: :shainmaster

  def update_getshozan_of_next_month
    date = 年月.to_date
    return if date.month == 12
    next_month = (date + 1.month).strftime('%Y/%m')
    # tim ra ykkk cua cac thang sau:
    ykkk = YuukyuuKyuukaRireki.find_by(社員番号: 社員番号, 年月: next_month)
    if ykkk
      kyuukei_times = ykkk.月初有給残.to_f - ykkk.月末有給残.to_f
      kyuukei_times = 0.0 if kyuukei_times < 0.0
      ykkk.月初有給残 = 月末有給残 || 0.0
      ykkk.月末有給残 = ykkk.月初有給残 - kyuukei_times
      ykkk.月末有給残 = 0.0 if ykkk.月末有給残 < 0.0
      ykkk.save
    end
  end

  def calculate_getshozan
    return if 月初有給残.present?
    date = 年月.to_date
    first_month = date.beginning_of_year.strftime('%Y/%m')
    prev_month = (date - 1.month).strftime('%Y/%m')
    # tim ra nhung ykkk cua cac thang truoc:
    ykkks = YuukyuuKyuukaRireki.where(社員番号: 社員番号, 年月: first_month..prev_month)
    last_month_has_getmatsuzan = ykkks.map { |ykkk| { month: ykkk.年月.to_date.month, getmatsuzan: ykkk.月末有給残 } }
                    .sort_by { |i| - i[:month] }
                    .find { |i| i[:getmatsuzan].present? && i[:getmatsuzan].to_f >= 0.0 }
    self.月初有給残 = last_month_has_getmatsuzan ? last_month_has_getmatsuzan[:getmatsuzan] : 12.0
  end

  def calculate_getmatsuzan(kintais = [])
    date = 年月.to_date
    kintais = Kintai.where(社員番号: 社員番号, 日付: date.beginning_of_month..date.end_of_month).order(:日付) if kintais.empty?
    yuukyu = 0
    kintais.each do |kintai|
      case kintai.状態1
      when '30' then yuukyu += 1
      when '31', '32' then yuukyu += 0.5
      end
    end
    calculate_getshozan if 月初有給残.blank?
    self.月末有給残 = (月初有給残.to_f - yuukyu).to_f
    self.月末有給残 = 0.0 if self.月末有給残 < 0.0
  end
end
