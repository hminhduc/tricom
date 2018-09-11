FactoryBot.define do
  factory :mybashomaster do
    社員番号 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    場所コード { Bashomaster.first&.場所コード || association(:bashomaster).場所コード }
    場所名 { 'name1' }
  end
end
