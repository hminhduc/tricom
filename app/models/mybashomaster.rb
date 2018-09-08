class Mybashomaster < ApplicationRecord
  self.table_name = :MY場所マスタ
  self.primary_key = :場所コード,:社員番号
  CSV_HEADERS = %w(社員番号 場所コード 場所名 場所名カナ SUB 場所区分 会社コード 更新日)
  validates :場所コード, :場所名, :社員番号, presence: true
  validates :場所コード, uniqueness: {scope: :社員番号}
  validates :会社コード, presence: true, if: :basho_kubun?
  # validates :会社コード, inclusion: {in: Kaishamaster.pluck(:会社コード)}, allow_blank: true

  has_many :events

  belongs_to :kaishamaster, foreign_key: :会社コード
  belongs_to :bashokubunmst, foreign_key: :場所区分
  belongs_to :shainmaster, foreign_key: :社員番号
  belongs_to :bashomaster, foreign_key: :場所コード
  delegate :name, to: :kaishamaster, prefix: :kaisha, allow_nil: true

  # alias_attribute :id, :場所コード
  # alias_attribute :name, :場所名

  def basho_kubun?
    場所区分 == '2'
  end
end
