class JptHolidayMst < ApplicationRecord
  CSV_HEADERS = %w(event_date title description)
  include PgSearch
  multisearchable against: %w{title description}
  validates :event_date, presence: true, uniqueness: true
end
