FactoryBot.define do
  factory :dengon do
    from1 { 'ジュピター' }
    from2 { '石井' }
    日付 { '2018-08-01 05:34:00' }
    入力者 { Shainmaster.first&.社員番号 || association(:shainmaster).社員番号 }
    用件 { '6' }
    回答 { '10' }
    伝言内容 { '8/6～8/7の出張申請に判子借りて提出しました。\r\nちなみに8/6は湊川さんも同席してもらうことに...' }
    確認 { true }
    送信 { true }
    社員番号 { Shainmaster.first&.社員番号 || association(:shainmaster, :second).社員番号 }
  end
end
