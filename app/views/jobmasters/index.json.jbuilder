json.jobs(@jobmasters) do |jobmaster|
  json.extract! jobmaster, :job番号, :job名, :開始日, :終了日, :ユーザ番号, :ユーザ名, :入力社員番号, :分類コード, :分類名, :関連Job番号, :備考, :受注金額, :納期, :JOB内訳区分
end
