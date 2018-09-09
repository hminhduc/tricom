FactoryBot.define do
  factory :myjobmaster do
    社員番号 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    job番号 { Jobmaster.first&.job番号 || association(:jobmaster).job番号 }
    job名 { 'kamejoko' }
  end
end
