class Keihibody < ApplicationRecord
  self.table_name = :keihi_bodies
  CSV_HEADERS = %w(id 申請番号 日付 社員番号 相手先 機関名 発 着 発着kubun 交通費 日当 宿泊費 その他 JOB 備考 領収書kubun)
  # self.primary_keys = [:申請番号,:行番号]
  # self.primary_key = :申請番号
  # include PgSearch
  # multisearchable :against => %w{id 申請番号 日付 社員番号 相手先 機関名 発 着 発着kubun 交通費 日当
  #     宿泊費 その他 JOB 備考 領収書kubun}
  belongs_to :keihihead, foreign_key: :申請番号
  scope :current_member, ->(member) { where( 社員番号: member )}

  validates :相手先, :機関名, :発, :着, :交通費, :日当, :宿泊費, :その他, :JOB, :備考, presence: { messages: I18n.t('app.flash.unsucess') }
  validates :相手先, inclusion: {in: proc{Kaishamaster.pluck(:会社名)}}, allow_blank: true
  validates :JOB, inclusion: {in: proc{Jobmaster.pluck(:job番号)}}, allow_blank: true
  validates :機関名, inclusion: {in: proc{Kikanmst.pluck(:機関名)}}, allow_blank: true
  validates :発, inclusion: {in: proc{Eki.pluck(:駅名)}}, allow_blank: true
  validates :着, inclusion: {in: proc{Eki.pluck(:駅名)}}, allow_blank: true
end
