FactoryBot.define do
  factory :bashomaster do
    場所コード { '12345' }
    場所名 { 'test 場所名' }
    場所名カナ { 'test 場所名カナ' }
    SUB { 'test SUB' }
    場所区分 { Bashokubunmst.first&.場所区分コード || association(:bashokubunmst).場所区分コード }
    会社コード { Kaishamaster.first&.会社コード || association(:kaishamaster).会社コード }

    trait :second do
    	場所コード { '23456' }
    end
  end
end
