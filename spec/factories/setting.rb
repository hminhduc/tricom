FactoryBot.define do
  factory :setting do
    社員番号 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    scrolltime { '06:00' }
    local { 'ja' }
    select_holiday_vn { '0' }

    trait :second do
      優先さ { 2 }
      備考 { 'note2' }
      色 { '#f0ed8d' }
    end
  end
end
