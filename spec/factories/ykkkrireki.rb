FactoryBot.define do
  factory :yuukyuu_kyuuka_rireki do
    社員番号 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    年月 { '2018/09' }
    月初有給残 { 10.0 }
    月末有給残 { 8.0 }

    trait :next_month do
      年月 { '2018/10' }
    end

    trait :before_month do
      年月 { '2018/03' }
      月末有給残 { 5.0 }
    end
  end
end
