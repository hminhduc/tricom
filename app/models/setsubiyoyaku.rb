class Setsubiyoyaku < ApplicationRecord
  self.table_name = :設備予約
  CSV_HEADERS = %w{設備コード 予約者 相手先 開始 終了 用件}

  include PgSearch
  multisearchable against: %w{設備コード setsubi_設備名 shain_氏名 kaisha_会社名 開始 終了 用件}
  validates :設備コード, :開始, :終了, presence: true

  belongs_to :setsubi, foreign_key: :設備コード
  belongs_to :shainmaster, foreign_key: :予約者
  belongs_to :kaishamaster, foreign_key: :相手先

  delegate :設備名, to: :setsubi, prefix: :setsubi, allow_nil: true
  delegate :氏名, to: :shainmaster, prefix: :shain, allow_nil: true
  delegate :会社名, to: :kaishamaster, prefix: :kaisha, allow_nil: true

  validate :check_date_input

  private

    def check_date_input
      return unless 開始.present? && 終了.present?
      begin_t = 開始.to_datetime
      end_t = 終了.to_datetime
      errors.add(:終了, (I18n.t 'app.model.check_data_input')) if begin_t >= end_t
      Setsubiyoyaku.where(設備コード: 設備コード).where.not(id: id).each do |setsubiyoyaku|
        errors.add(:設備コード, (I18n.t 'app.model.schedule')) if setsubiyoyaku.開始.to_datetime.between?(begin_t, end_t) || setsubiyoyaku.終了.to_datetime.between?(begin_t, end_t)
      end
    end
end
