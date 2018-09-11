FactoryBot.define do
  factory :dengonyouken do
    種類名 { '電話' }
    備考 { '０１' }
    color { '#e6e6fa' }
    優先さ { Yuusen.first&.優先さ || association(:yuusen).優先さ }
  end
end
