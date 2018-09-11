FactoryBot.define do
  factory :kouteimaster do
    所属コード { Shozokumaster.first&.所属コード || association(:shozokumaster).所属コード }
    工程コード { '123' }
    工程名 { 'name1' }

    trait :second do
      所属コード { Shozokumaster.second&.所属コード || association(:shozokumaster, :second).所属コード }
      工程コード { '456' }
      工程名 { 'name2' }
    end
  end
end
