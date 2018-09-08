class Joutaimaster < ApplicationRecord
  self.table_name = :状態マスタ
  self.primary_key = :状態コード
  CSV_HEADERS = %w(状態コード 状態名 状態区分 勤怠状態名 マーク 色 文字色 WEB使用区分 勤怠使用区分)
  include PgSearch
  multisearchable :against => %w{状態コード 状態名 状態区分 勤怠状態名 マーク 色 文字色 WEB使用区分 勤怠使用区分}
  scope :web_use, -> { where( WEB使用区分:'1')}

  validates :状態コード, :状態名, presence: true
  validates :状態コード, uniqueness: true

  has_many :event, foreign_key: :状態コード, dependent: :destroy
  has_many :kintais, foreign_key: :状態1, dependent: :nullify

  alias_attribute :id, :状態コード
  alias_attribute :name, :状態名
  alias_attribute :color, :色
  alias_attribute :text_color, :文字色

  scope :active, ->(kubunlist) { where(勤怠使用区分: '1', 状態区分:kubunlist) }

  def events
    super || build_events
  end
end
