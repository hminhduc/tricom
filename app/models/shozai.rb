class Shozai < ApplicationRecord
  self.table_name = :所在マスタ
  self.primary_key = :所在コード
  CSV_HEADERS = %w{所在コード 所在名 背景色 文字色}
  include PgSearch
  multisearchable :against => %w{所在コード 所在名 背景色 文字色}
  validates :所在コード, :所在名, presence: true
  validates :所在コード, uniqueness: true

  # has_many :events
  has_many :shainmasters, foreign_key: :所在コード

  alias_attribute :id, :所在コード
  alias_attribute :name, :所在名
  alias_attribute :background_color, :背景色
  alias_attribute :text_color, :文字色
end
