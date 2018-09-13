class Kaishamaster < ApplicationRecord
  self.table_name = :会社マスタ
  self.primary_key = :会社コード
  CSV_HEADERS = %w(会社コード 会社名 備考)
  SHOW_ATTRS = %w(id name note)
  after_update :doUpdateMykaisha
  include PgSearch
  multisearchable against: %w{会社コード 会社名 備考}
  validates :会社コード, :会社名, presence: true
  validates :会社コード, uniqueness: true

  has_one :bashomaster, dependent: :destroy, foreign_key: :会社コード
  has_one :jobmaster, foreign_key: :ユーザ番号, dependent: :nullify
  has_many :setsubiyoyaku, dependent: :destroy, foreign_key: :相手先
  has_many :mykaishamaster, dependent: :destroy, foreign_key: :会社コード
  alias_attribute :id, :会社コード
  alias_attribute :name, :会社名
  alias_attribute :note, :備考

  def doUpdateMykaisha
    mykaishas = Mykaishamaster.where(会社コード: self.会社コード).update_all(会社名: self.会社名, 備考: self.備考)
  end
end
