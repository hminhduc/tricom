FactoryBot.define do
  factory :yakushokumaster do
    役職コード { '10' }
    役職名 { '役員' }

    trait :second do
      役職コード { '12' }
      役職名 { '役員' }
    end
  end
end
