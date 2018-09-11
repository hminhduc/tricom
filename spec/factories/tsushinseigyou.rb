FactoryBot.define do
  factory :tsushinseigyou do
    社員番号 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    メール { 'a@gmail.com' }
    送信許可区分 { '1' }

    trait :nosend do
      送信許可区分 { '0' }
    end
  end
end
