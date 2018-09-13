FactoryBot.define do
  factory :event do
    社員番号 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    状態コード { Joutaimaster.first&.状態コード || association(:joutaimaster).状態コード }
    開始 { '2000-1-1 1:00' }
    終了 { '2000-1-1 2:00' }
    場所コード { Bashomaster.first&.場所コード || association(:bashomaster).場所コード }
    JOB { Jobmaster.first&.job番号 || association(:jobmaster).job番号 }
  end
end
