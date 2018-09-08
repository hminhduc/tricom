class Yakushokumaster < ApplicationRecord
  self.table_name = :役職マスタ
  self.primary_key = :役職コード
  CSV_HEADERS = %w{役職コード 役職名}
  include PgSearch
  multisearchable :against => %w{役職コード 役職名}
  validates :役職コード, :役職名, presence: true
  validates :役職コード, uniqueness: true

  has_many :shainmasters, foreign_key: :役職コード

  alias_attribute :id, :役職コード
end
