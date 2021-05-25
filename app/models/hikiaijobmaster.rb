class Hikiaijobmaster < ApplicationRecord
  self.table_name = :JOB引合マスタ
  self.primary_key = :job番号
  CSV_HEADERS = %w(job番号 job名 開始日 終了日 ユーザ番号 ユーザ名 紹介元名 入力社員番号 備考)
  HEADERS = %w(job番号 job名 開始日 終了日 ユーザ番号 ユーザ名 紹介元名 入力社員番号 備考)
  PRIMARY_KEYS = %w(job番号)

  include PgSearch
  multisearchable against: %w{job番号 job名 ユーザ番号 ユーザ名 紹介元名 入力社員番号 備考}
  validates :job番号, uniqueness: true
  validates :job番号, :job名, presence: true
  validates :入力社員番号, numericality: { only_integer: true }, inclusion: { in: proc { Shainmaster.pluck(:社員番号) } }, allow_blank: true
  validates :ユーザ番号, inclusion: { in: proc { Kaishamaster.pluck(:会社コード) } }, allow_blank: true
  validate :check_input

  has_one :event, foreign_key: :JOB引合, dependent: :destroy
  belongs_to :kaishamaster, class_name: :Kaishamaster, foreign_key: :ユーザ番号
  belongs_to :shainmaster, class_name: :Shainmaster, foreign_key: :入力社員番号
  alias_attribute :id, :job番号
  alias_attribute :job_name, :job名

  def check_input
    errors.add(:終了日, (I18n.t 'app.model.check_data_input')) if 開始日.present? && 終了日.present? && 開始日 > 終了日
  end
end
