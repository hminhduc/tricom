FactoryBot.define do
  factory :kintaiteeburu do
    勤務タイプ { '001' }
    出勤時刻 { '07:00' }
    退社時刻 { '16:00' }

    trait :second do
      勤務タイプ { '001' }
      出勤時刻 { '07:00' }
      退社時刻 { '16:30' }
    end
  end
end
