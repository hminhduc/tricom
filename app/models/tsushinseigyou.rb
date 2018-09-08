class Tsushinseigyou < ApplicationRecord
  self.table_name = :通信制御マスタ
  CSV_HEADERS = %w{社員番号 メール 送信許可区分}
  validates :社員番号, presence: true
  validates :社員番号, uniqueness: true
  validates_format_of :メール, :with => /(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z)|(^$)/i, message: I18n.t('errors.messages.wrong_mail_form')
  belongs_to :shainmaster, foreign_key: :社員番号
  delegate :氏名, to: :shainmaster, prefix: :shain, allow_nil: true
  include PgSearch
  multisearchable :against => %w{shain_氏名 メール}
end
