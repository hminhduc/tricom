class Dengonyouken < ApplicationRecord
  self.table_name = :伝言用件マスタ
  CSV_HEADERS = %w(id 種類名 備考 優先さ)
  include PgSearch
  multisearchable :against => %w{種類名 備考}
  validates :種類名, presence: true
  validates :種類名, uniqueness: true
  validates :優先さ,   inclusion: {in: proc{Yuusen.pluck(:優先さ)}}, allow_blank: false
  belongs_to :yuusen, foreign_key: :優先さ

  delegate :優先さ, to: :yuusen, allow_nil: true
end
