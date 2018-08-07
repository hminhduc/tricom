class Sagyoukubun < ApplicationRecord
  self.table_name = :作業区分内訳

  validates :作業区分, :作業区分名称, presence: true
  validates :作業区分, uniqueness: true
end
