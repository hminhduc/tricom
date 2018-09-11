FactoryBot.define do
  factory :kairanyokenmst do
    名称 { '回覧' }
    備考 { '０１' }
    color { '#e6e6fa' }
    優先さ { Yuusen.first&.優先さ || association(:yuusen).優先さ }
  end
end
