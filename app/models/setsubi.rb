class Setsubi < ApplicationRecord
  self.table_name = :設備マスタ
  self.primary_key = :設備コード
  CSV_HEADERS = %w(設備コード 設備名 備考)
  SHOW_ATTRS = %w(設備コード 設備名 備考)
  include PgSearch
  multisearchable against: %w{設備コード 設備名 備考}
  validates :設備コード, :設備名, presence: true
  validates :設備コード, uniqueness: true
  has_many :setsubiyoyaku, dependent: :destroy, foreign_key: :設備コード
end
