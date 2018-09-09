class Bunrui < ApplicationRecord
  self.table_name = :分類マスタ
  self.primary_key = :分類コード
  HEADERS = CSV_HEADERS = %w(分類コード 分類名)
  PRIMARY_KEYS = %w(分類コード)
  SHOW_ATTRS = %w(分類コード 分類名)
  include PgSearch
  multisearchable :against => CSV_HEADERS
  validates :分類コード, uniqueness: true
  validates :分類コード, :分類名, presence: true

  has_one :jobmaster, foreign_key: :分類コード, dependent: :nullify
end
