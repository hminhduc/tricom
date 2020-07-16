class Kairanshosai < ApplicationRecord
  self.table_name = :回覧詳細
  CSV_HEADERS = %w(回覧コード 対象者 created_at updated_at 状態)
  # include PgSearch
  # multisearchable against: %w{回覧コード 対象者 created_at updated_at 状態}
  belongs_to :kairan, foreign_key: :回覧コード, class_name: 'Kairan'
  belongs_to :shainmaster, foreign_key: :対象者

  delegate :要件, to: :kairan, allow_nil: true
  delegate :開始, to: :kairan, allow_nil: true
  delegate :件名, to: :kairan, allow_nil: true
  delegate :内容, to: :kairan, allow_nil: true
  # delegate :確認, to: :kairan, allow_nil: true
  enum 状態: [:未確認, :確認済, :回答済]
end
