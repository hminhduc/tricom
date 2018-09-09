FactoryBot.define do
  factory :user do
    email { 'hungnd@gmail.com' }
    担当者コード { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    担当者名称 { 'user' }
    password { '999999999' }

    trait :second do
    	担当者コード { Shainmaster.second&.社員番号 || association(:shainmaster, :second).社員番号 }
	    担当者名称 { 'user2' }
	    password { '999999999' }
    end
  end
end
