class Shozokumaster < ApplicationRecord
  self.table_name = :所属マスタ
  self.primary_key = :所属コード
  CSV_HEADERS = %w{所属コード 所属名}
  include PgSearch
  multisearchable :against => %w{所属コード 所属名}
  validates :所属コード, :所属名, presence: true
  validates :所属コード, uniqueness: true

  has_many :kouteimasters, foreign_key: :所属コード
  has_one :shainmaster, foreign_key: :所属コード

  alias_attribute :id, :所属コード
  alias_attribute :name, :所属名
end
