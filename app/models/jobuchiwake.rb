class Jobuchiwake < ApplicationRecord
  self.table_name = :JOB内訳マスタ
  self.primary_key = :ジョブ内訳番号

  belongs_to :jobmaster, foreign_key: :ジョブ番号
  validates :ジョブ番号, inclusion: {in: proc{Jobmaster.pluck(:job番号)}}, allow_blank: true

  UKETSUKESHUBETSU = {
    '1' => 'PG障害',
    '2' => '障害',
    '3' => '調査',
    '4' => '依頼',
    '5' => '打合せ',
    '6' => 'リリース',
    'A' => '要望'
  }
  validates :ジョブ内訳番号, :ジョブ番号, presence: true
  validates :ジョブ内訳番号, uniqueness: true
end
