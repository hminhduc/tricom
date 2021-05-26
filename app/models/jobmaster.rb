class Jobmaster < ApplicationRecord
  self.table_name = :JOBマスタ
  self.primary_key = :job番号
  CSV_HEADERS = %w(job番号 job名 開始日 終了日 ユーザ番号 ユーザ名 入力社員番号 分類コード 分類名 関連Job番号 備考)
  HEADERS = %w(job番号 job名 開始日 終了日 ユーザ番号 ユーザ名 入力社員番号 分類コード 関連Job番号 備考 受注金額 納期)
  PRIMARY_KEYS = %w(job番号)

  after_update :doUpdateMyjob
  include PgSearch
  multisearchable against: %w{job番号 job名 ユーザ番号 ユーザ名 入力社員番号 分類コード 分類名 関連Job番号 備考}
  validates :job番号, uniqueness: true
  validates :job番号, :job名, presence: true
  validates :入力社員番号, numericality: { only_integer: true }, inclusion: { in: proc { Shainmaster.pluck(:社員番号) } }, allow_blank: true
  validates :関連Job番号, numericality: { only_integer: true }, inclusion: { in: proc { Jobmaster.pluck(:job番号) } }, allow_blank: true
  validates :ユーザ番号, inclusion: { in: proc { Kaishamaster.pluck(:会社コード) } }, allow_blank: true
  validates :分類コード, inclusion: { in: proc { Bunrui.pluck(:分類コード) } }, allow_blank: true
  validate :check_input

  has_one :event, foreign_key: :JOB, dependent: :destroy
  belongs_to :kaishamaster, class_name: :Kaishamaster, foreign_key: :ユーザ番号
  belongs_to :bunrui, foreign_key: :分類コード
  belongs_to :shainmaster, class_name: :Shainmaster, foreign_key: :入力社員番号
  belongs_to :jobkanren, class_name: :Jobmaster, foreign_key: :関連Job番号
  has_many :jobmaster, foreign_key: :関連Job番号, dependent: :nullify
  has_many :myjobmaster, dependent: :destroy, foreign_key: :job番号
  has_many :jobuchiwake, dependent: :destroy, foreign_key: :ジョブ番号
  alias_attribute :id, :job番号
  alias_attribute :job_name, :job名
  delegate :分類名, to: :bunrui, prefix: :bunrui, allow_nil: true

  def doUpdateMyjob
    myjobs = Myjobmaster.where(job番号: self.job番号).update_all(job名: self.job名, 開始日: self.開始日, 終了日: self.終了日, ユーザ番号: self.ユーザ番号, ユーザ名: self.ユーザ名, 入力社員番号: self.入力社員番号, 分類コード: self.分類コード, 分類名: self.分類名, 備考: self.備考)
  end

  def check_input
    errors.add(:終了日, (I18n.t 'app.model.check_data_input')) if 開始日.present? && 終了日.present? && 開始日 > 終了日
    errors.add(:JOB引合区分, 'とJOB内訳区分が同時にONにすることはできません') if self.JOB引合区分 && self.JOB内訳区分
  end
end
