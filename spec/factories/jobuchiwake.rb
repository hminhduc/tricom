FactoryBot.define do
  factory :jobuchiwake do
    ジョブ番号 { Jobmaster.first&.job番号 || association(:jobmaster).job番号 }
    ジョブ内訳番号 { '2641' }
    受付日時 { '2017-08-27 17:00:00' }
    件名 { '（原価管理）原価代表品番マスタ' }
    受付種別 { '2' }
  end
end
