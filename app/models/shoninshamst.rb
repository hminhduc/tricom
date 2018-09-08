class Shoninshamst < ApplicationRecord
  self.table_name = :承認者マスタ
  CSV_HEADERS = %w{申請者 承認者 順番}
  include PgSearch
  multisearchable :against => %w{shinseisha_氏名 shouninsha_氏名 順番}
  scope :current_user, ->(member) {where( 承認者: member)}
  belongs_to :shouninsha, foreign_key: :承認者, class_name: 'Shainmaster'
  belongs_to :shinseisha, foreign_key: :申請者, class_name: 'Shainmaster'
  delegate :氏名, to: :shainmaster, prefix: :shainmaster, allow_nil: true

  validates :申請者, :承認者, presence: true

  delegate :title, to: :shouninsha, prefix: :shonin, allow_nil: true
  delegate :氏名, to: :shinseisha, prefix: :shinseisha, allow_nil: true
  delegate :氏名, to: :shouninsha, prefix: :shouninsha, allow_nil: true
  validate :check_shainmaster_equal
  validates :申請者, uniqueness: { scope: :承認者 }
  validates :承認者, uniqueness: { scope: :申請者 }

  private
  def check_shainmaster_equal
    if self.申請者 == self.承認者
      errors.add(:申請者, (I18n.t 'app.model.check_shainmaster_equal'))
      errors.add(:承認者, (I18n.t 'app.model.check_shainmaster_equal'))
    end
  end
end
