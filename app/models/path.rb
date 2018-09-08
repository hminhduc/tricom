class Path < ApplicationRecord
  self.table_name = :paths
  CSV_HEADERS = %w(title_jp title_en model_name_field path_url)
  validates :path_url, presence: true
end
