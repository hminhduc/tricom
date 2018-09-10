FactoryBot.define do
  factory :shainmaster do
    社員番号 { '123456789' }
    氏名 { 'shain' }
    連携用社員番号 { '123456789' }

    trait :unstrip do
      社員番号 { ' abc 123     ' }
    end

    trait :second do
      社員番号 { '987654321' }
      氏名 { 'shain2' }
      連携用社員番号 { '987654321' }
    end
  end
end
