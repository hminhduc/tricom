FactoryBot.define do
  factory :jobmaster do
    job番号 { '13032' }
    job名 { 'NHF茨城PLC打合' }

    trait :second do
      job番号 { '113329' }
      job名 { 'Job番号桁間違い' }
    end
  end
end
