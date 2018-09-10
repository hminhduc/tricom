FactoryBot.define do
  factory :event do
    社員番号 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    状態コード { Joutaimaster.first&.状態コード || association(:joutaimaster).状態コード }
    開始 { '2000-1-1 1:00' }
    終了 { '2000-1-1 2:00' }
  end
end
