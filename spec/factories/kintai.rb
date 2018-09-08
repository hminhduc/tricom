FactoryBot.define do
  factory :kintai do
    日付 { '2018-09-01'.to_date }
    社員番号 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    状態1 { Joutaimaster.first&.状態コード || association(:joutaimaster).状態コード }
    出勤時刻 { DateTime.now }
    退社時刻 { 10.hours.from_now }
  end
end
