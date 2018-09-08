class Rorumenba < ApplicationRecord
	self.table_name = :ロールメンバ
	self.primary_keys = :ロールコード, :社員番号
  CSV_HEADERS = %w(ロールコード 社員番号 氏名 ロール内序列)
  include PgSearch
  multisearchable :against => %w{ロールコード rorumaster_ロール名 社員番号 氏名 ロール内序列}
  validates :ロールコード,:社員番号, presence: true
  validates :ロール内序列, length: {maximum: 10}
	belongs_to :shainmaster, foreign_key: :社員番号
	belongs_to :rorumaster, foreign_key: :ロールコード
  delegate :ロール名, to: :rorumaster, prefix: :rorumaster, allow_nil: true
end
