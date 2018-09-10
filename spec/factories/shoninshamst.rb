FactoryBot.define do
  factory :shoninshamst do
    申請者 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    承認者 { Shainmaster.second&.社員番号 || association(:shainmaster, :second).社員番号 }
    順番 { 1 }

    trait :same_shain do
      申請者 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
      承認者 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    end
  end
end
