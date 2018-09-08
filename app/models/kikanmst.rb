class Kikanmst < ApplicationRecord
  CSV_HEADERS = %w(機関コード 機関名 備考)
  include PgSearch
  multisearchable :against => [:機関コード, :機関名, :備考]
  self.table_name = :機関マスタ
  self.primary_key = :機関コード

  validates :機関コード, :機関名, presence: true
  validates :機関コード, uniqueness: true

  alias_attribute :id, :機関コード
  alias_attribute :name, :機関名
  alias_attribute :note, :備考
end
