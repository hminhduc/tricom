FactoryBot.define do
  factory :yuusen do
    優先さ { 1 }
    備考 { 'note' }
    色 { '#f0ed8c' }

    trait :second do
      優先さ { 2 }
      備考 { 'note2' }
      色 { '#f0ed8d' }
    end
  end
end
