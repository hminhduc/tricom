FactoryBot.define do
  factory :setsubiyoyaku do
    設備コード { Setsubi.first&.設備コード || association(:setsubi).設備コード }
    予約者 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    相手先 { Kaishamaster.first&.会社コード || association(:kaishamaster).会社コード }
    開始 { '2000-01-01 09:00' }
    終了 { '2000-01-01 11:00' }

    trait :second do
      開始 { '2000-01-01 15:00' }
      終了 { '2000-01-01 16:00' }
    end

    trait :same_time do
      開始 { '2000-01-01 10:59' }
      終了 { '2000-01-01 12:00' }
    end

    trait :invalid_time do
      開始 { '2000-01-01 2:00' }
      終了 { '2000-01-01 1:00' }
    end
  end
end
