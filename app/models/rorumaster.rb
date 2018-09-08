class Rorumaster < ApplicationRecord
	self.table_name = :ロールマスタ
	self.primary_key = :ロールコード
  CSV_HEADERS = %w(ロールコード ロール名 序列)

  include PgSearch
  multisearchable :against => %w{ロールコード ロール名 序列}
  validates :ロールコード,:ロール名, presence: true
  validates :ロールコード, uniqueness: true
  validates :ロールコード, length: {maximum: 10}
  validates :ロール名, length: {maximum: 40}
  validates :序列, length: {maximum: 10}
	has_many :rorumenba, dependent: :destroy, foreign_key: :ロールコード
  has_many :shainmasters, foreign_key: :ロールコード
end
