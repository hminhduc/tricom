class Kairanyokenmst < ApplicationRecord
  self.table_name = :回覧用件マスタ
  CSV_HEADERS = %w(id 名称 備考 優先さ)
  SHOW_ATTRS = %w(id 名称 備考 優先さ)
  include PgSearch
  multisearchable :against => %w{名称 備考}
  validates :名称, presence: true
  validates :名称, uniqueness: true
  validates :優先さ,   inclusion: {in: proc{Yuusen.pluck(:優先さ)}}, allow_blank: false
  belongs_to :yuusen, foreign_key: :優先さ

  delegate :優先さ, to: :yuusen, allow_nil: true
end
