class Dengonkaitou < ApplicationRecord
  self.table_name = :伝言回答マスタ
  CSV_HEADERS = %w(id 種類名 備考)
  SHOW_ATTRS = %w(id 種類名 備考)
  include PgSearch
  multisearchable against: %w{種類名 備考}
  validates :種類名, presence: true
  validates :種類名, uniqueness: true
end
