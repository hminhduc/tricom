FactoryBot.define do
  factory :sagyoukubun do
    作業区分 { '1' }
    作業区分名称 { '打合せ' }

    trait :second do
      作業区分 { '2' }
      作業区分名称 { '打合せ2' }
    end
  end
end
