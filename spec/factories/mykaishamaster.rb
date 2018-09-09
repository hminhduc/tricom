FactoryBot.define do
  factory :mykaishamaster do
  	社員番号 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    会社コード { Kaishamaster.first&.会社コード || association(:kaishamaster).会社コード }
    会社名 { 'kamejoko' }
  end
end
