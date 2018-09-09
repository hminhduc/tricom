class Setting < ApplicationRecord
  self.table_name = :setting_tables
  self.primary_keys =  :社員番号
  CSV_HEADERS = %w{社員番号 scrolltime local select_holiday_vn}
  SHOW_ATTRS = %w(社員番号 scrolltime local select_holiday_vn turning_data)
  # include PgSearch
  # multisearchable :against => %w{社員番号 scrolltime local}
  validates :社員番号, presence: true
  validates :社員番号, uniqueness: true
  belongs_to :shainmaster, foreign_key: :社員番号
end
