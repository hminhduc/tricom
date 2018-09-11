FactoryBot.define do
  factory :shozokumaster do
    所属コード { '1' }
    所属名 { '営業グループ' }

    trait :second do
      所属コード { '2' }
      所属名 { '企画グループ' }
    end
  end
end
