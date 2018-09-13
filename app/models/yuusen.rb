class Yuusen < ApplicationRecord
  self.table_name = :優先
  self.primary_key = :優先さ
  CSV_HEADERS = %w{優先さ 備考 色}
  include PgSearch
  multisearchable against: %w{優先さ 備考 色}
  validates :優先さ, presence: true
  validates :優先さ, uniqueness: true
  has_many :kairanyokenmsts, foreign_key: :優先さ, dependent: :nullify
  has_many :dengonyoukens, foreign_key: :優先さ
end
