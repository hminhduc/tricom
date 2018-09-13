class Eki < ApplicationRecord
  CSV_HEADERS = %w(駅コード 駅名 駅名カナ 選択回数)
  HEADERS = %w(駅コード 駅名 駅名カナ)
  PRIMARY_KEYS = %w(駅コード)
  SHOW_ATTRS = %w(id name 駅名カナ)
  include PgSearch
  multisearchable against: [:駅コード, :駅名, :駅名カナ]

  self.table_name = :駅マスタ
  self.primary_key = :駅コード

  validates :駅コード, :駅名, presence: true
  validates :駅コード, uniqueness: true

  alias_attribute :id, :駅コード
  alias_attribute :name, :駅名
end
