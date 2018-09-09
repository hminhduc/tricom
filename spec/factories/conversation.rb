FactoryBot.define do
  factory :conversation do
    sender_id { User.first&.担当者コード || association(:user).担当者コード }
    recipient_id { User.second&.担当者コード || association(:user, :second).担当者コード }
  end
end
