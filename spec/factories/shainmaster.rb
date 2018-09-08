FactoryBot.define do
  factory :shainmaster do
    社員番号 { '123456789' }
    氏名 { 'shain' }
    連携用社員番号 { '123456789' }

    trait :unstrip do
      社員番号 { ' abc 123  	 ' }
    end
  end
end
