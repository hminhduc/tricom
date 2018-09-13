class Kouteimaster < ApplicationRecord
  self.table_name = :工程マスタ
  self.primary_keys = :工程コード, :所属コード
  CSV_HEADERS = %w(所属コード 工程コード 工程名)
  SHOW_ATTRS = %w(id 所属コード shozokumaster_name code name)
  include PgSearch
  multisearchable against: %w{shozokumaster_name 工程コード 工程名}
  validates :所属コード, :工程コード, :工程名, presence: true
  validates :工程コード, uniqueness: { scope: :所属コード }

  belongs_to :shozokumaster, foreign_key: :所属コード
  has_one :event, foreign_key: [:工程コード, :所属コード]

  alias_attribute :shozokucode, :所属コード
  alias_attribute :code, :工程コード
  alias_attribute :name, :工程名

  delegate :id, to: :shozokumaster, prefix: true, allow_nil: true
  delegate :name, to: :shozokumaster, prefix: true, allow_nil: true
end
